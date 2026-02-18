import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:device_info_plus/device_info_plus.dart';
import '../../components/alerts/fire_alert/fire_alert_widget.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../pages/dashboard/notification_manager.dart';
import '../../services/shared_preference/shared_preference.dart';
import '../../services/showflutter_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../pages/in_app_notifications/model/in_app_notifications_model.dart';
import 'fcm_model.dart';
import 'package:audio_session/audio_session.dart';

@pragma('vm:entry-point')
class NotificationPlugin {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static late AndroidNotificationChannel channel;
  static final BehaviorSubject<ReceivedNotification>
  didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static SharedPreference sharedPreference = SharedPreference();
  final StreamController<String> selectNotificationStream =
      StreamController<String>.broadcast();
  final StreamController<ReceivedNotification>
  didReceiveLocalNotificationStream =
      StreamController<ReceivedNotification>.broadcast();

  Future<void> init() async {
    log('🔔 NotificationPlugin.init() called');

    await initializePlatformSpecifics();

    // Configure audio session
    AudioSession.instance.then((audioSession) async {
      await audioSession.configure(const AudioSessionConfiguration.music());
    });

    // Setup FCM listeners
    firebaseCloudMessagingListeners();
    configureDidReceiveLocalNotificationSubject();

    // ✅ CRITICAL: Check for pending notifications IMMEDIATELY
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(
        Duration(milliseconds: 500),
      ); // Give UI time to build
      await checkAndProcessPendingNotifications();
    });

    // Handle notification launch from terminated state
    final appLaunchDetails = await flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();

    if (appLaunchDetails != null && appLaunchDetails.didNotificationLaunchApp) {
      log('🚀 App launched from notification tap');
      final payload = appLaunchDetails.notificationResponse?.payload;
      if (payload != null && payload.isNotEmpty) {
        log('📦 Launch payload: $payload');
        final data = jsonDecode(payload);

        // Cancel all notifications
        await flutterLocalNotificationsPlugin.cancelAll();

        // Show dialog when UI is ready
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (router.configuration.navigatorKey.currentContext != null) {
            _showNotificationDialog(data);
          } else {
            log('⚠️ Context not available, queuing dialog');
            ShowflutterNotification.queueDialog(
              NotificationData(
                buildingId: data["building_id"].toString(),
                name: data["name"]?.toString() ?? 'Unknown',
                dateTime: DateTime.now().toString(),
                body: data["body"]?.toString() ?? '',
                title: data["title"]?.toString() ?? 'Notification',
              ),
            );
          }
        });
      }
    }

    log('✅ NotificationPlugin.init() completed');
  }

  Future<void> checkAndProcessPendingNotifications() async {
  try {
    log('🔍 Checking for pending notifications...');

    final prefs = await SharedPreferences.getInstance();
    final hasPending = prefs.getBool('has_pending_notification') ?? false;
    final showImmediately = prefs.getBool('show_dialog_immediately') ?? false;

    if (hasPending) {
      log('📱 Found pending notification!');

      final payload = prefs.getString('pending_notification_data');


      // Clear the data immediately to prevent duplicate processing
      await prefs.remove('has_pending_notification');
      await prefs.remove('pending_notification_data');
      await prefs.remove('notification_timestamp');
      await prefs.remove('show_dialog_immediately');

      if (payload != null && payload.isNotEmpty) {
        log('📦 Processing: $payload');
        
        try {
          final data = jsonDecode(payload);
          
          // Cancel any existing notifications
          await flutterLocalNotificationsPlugin.cancelAll();

          // Show dialog with retry mechanism
          if (showImmediately) {
            _showDialogWithPriority(data, isHighPriority: true);
          } else {
            _showDialogWithRetry(data);
          }
        } catch (e) {
          log('❌ Error parsing payload: $e');
        }
      }
    } else {
      log('🔍 No pending notifications found');
    }
  } catch (e) {
    log('❌ Error checking pending notifications: $e');
  }
}

void _showDialogWithPriority(Map<String, dynamic> data, {bool isHighPriority = false}) {
  log('🎯 Showing dialog with priority: ${isHighPriority ? "HIGH" : "NORMAL"}');
  
  // Try immediately
  _attemptShowDialog(data, attempt: 0, maxAttempts: isHighPriority ? 20 : 10);
}

void _showDialogWithRetry(Map<String, dynamic> data) {
  _attemptShowDialog(data, attempt: 0, maxAttempts: 10);
}

void _attemptShowDialog(Map<String, dynamic> data, {required int attempt, required int maxAttempts}) {
  if (attempt > maxAttempts) {
    log('❌ Failed to show dialog after $maxAttempts attempts');
    return;
  }

  // Check if context is available
  final context = router.configuration.navigatorKey.currentContext;
  
  if (context != null && context.mounted) {
    log('✅ Context available, showing dialog on attempt $attempt');
    
    // Small delay to ensure UI is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => Dialog(
            backgroundColor: Colors.transparent,
            child: FireAlertWidget(
              notificationData: NotificationData(
                buildingId: data["building_id"].toString(),
                name: data["name"]?.toString() ?? 'Unknown',
                dateTime: data["timestamp"] ?? DateTime.now().toString(),
                body: data["body"]?.toString() ?? '',
                title: data["title"]?.toString() ?? 'Notification',
              ),
              buildingID: data["building_id"],
              buildingName: data["name"]?.toString() ?? 'Unknown',
            ),
          ),
        );
        log('✅ Dialog shown successfully');
      } catch (e) {
        log('❌ Error showing dialog: $e');
        // Retry with exponential backoff
        Future.delayed(Duration(milliseconds: 100 * (attempt + 1)), () {
          _attemptShowDialog(data, attempt: attempt + 1, maxAttempts: maxAttempts);
        });
      }
    });
  } else {
    log('⚠️ Context not ready, retrying... (attempt $attempt/$maxAttempts)');
    Future.delayed(Duration(milliseconds: 200 * (attempt + 1)), () {
      _attemptShowDialog(data, attempt: attempt + 1, maxAttempts: maxAttempts);
    });
  }
}

  void _showNotificationDialog(Map<String, dynamic> data) {
    log('🎯 Showing notification dialog...');
    log('   Building: ${data["name"]}');
    log('   Title: ${data["title"]}');

    showDialog(
      context: router.configuration.navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: FireAlertWidget(
          notificationData: NotificationData(
            buildingId: data["building_id"].toString(),
            name: data["name"]?.toString() ?? 'Unknown',
            dateTime: DateTime.now().toString(),
            body: data["body"]?.toString() ?? '',
            title: data["title"]?.toString() ?? 'Notification',
          ),
          buildingID: int.tryParse(data["building_id"]??0),
          buildingName: data["name"]?.toString() ?? 'Unknown',
        ),
      ),
    );
  }

  // Add this method to request permissions when the app is fully initialized
  Future<void> requestNotificationPermissions() async {
    if (Platform.isIOS) {
      await _requestIOSPermission();
    } else if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      int ver = androidInfo.version.sdkInt;

      if (ver >= 33) {
        try {
          PermissionStatus status = await Permission.notification.status;
          if (!status.isGranted) {
            await Permission.notification.request();
          }
        } catch (e) {
          log("Failed to request notification permission: $e");
          // Retry after a delay
          await Future.delayed(Duration(seconds: 1));
          await Permission.notification.request();
        }
      }
    }
  }

  Future<void> processPendingNotificationSafely() async {
    final prefs = await SharedPreferences.getInstance();
    final hasPending = prefs.getBool('has_pending_notification') ?? false;

    if (!hasPending) return;

    final payload = prefs.getString('pending_notification_data');
    if (payload == null || payload.isEmpty) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tryShowDialog(payload, retry: 0);
    });
  }

  void _tryShowDialog(String payload, {required int retry}) async {
    final context = router.configuration.navigatorKey.currentContext;

    if (context == null) {
      if (retry < 10) {
        Future.delayed(const Duration(milliseconds: 300), () {
          _tryShowDialog(payload, retry: retry + 1);
        });
      }
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('has_pending_notification');
    await prefs.remove('pending_notification_data');

    final data = jsonDecode(payload);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: FireAlertWidget(
          notificationData: NotificationData(
            buildingId: data["building_id"].toString(),
            name: data["name"] ?? '',
            dateTime: DateTime.now().toString(),
            body: data["body"] ?? '',
            title: data["title"] ?? '',
          ),
          buildingID: int.tryParse(data["building_id"] ?? ''),
          buildingName: data["name"],
        ),
      ),
    );
  }

  void configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream.listen(
      (ReceivedNotification receivedNotification) async {},
    );
  }

  void firebaseCloudMessagingListeners() {
    FirebaseMessaging.onMessage.listen(
      ShowflutterNotification.showFlutterNotification,
    );
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      try {
        _firebaseMessagingBackgroundHandler(message);
        if (message.toMap()['category'] == 'FLUTTER_NOTIFICATION_CLICK') {
          log("id of building: ${message.data["id"].toString()}");
        }
      } catch (e) {
        log('while receiving in terminated state$e');
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> setupToken(List<String> ids) async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null && token.isNotEmpty) {
        await saveTokenToDatabase(token, ids);
      }
      FirebaseMessaging.instance.onTokenRefresh.listen((value) async {
        await saveTokenToDatabase(value, ids);
      });
    } catch (e) {
      log(e.toString());
    }
  }

@pragma('vm:entry-point')
static Future<void> _firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  try {
    final data = message.data;

    final String body = data["body"] ?? message.notification?.body ?? "";
    final String title = data["title"] ?? message.notification?.title ?? "";
    final String buildingId =
        data["building_id"]?.toString() ?? data["id"]?.toString() ?? "";
    final String buildingName = data["building_name"] ?? data["name"] ?? "";

    if (body.isEmpty || title.isEmpty || buildingId.isEmpty) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    // Save notification data
    final notification = NotificationData(
      buildingId: buildingId,
      name: buildingName,
      dateTime: DateTime.now().toIso8601String(),
      body: body,
      title: title,
    );

    // Save to notification manager
    final existing = await NotificationBadgeManager.fetchNotifications();
    existing.add(notification);
    await NotificationBadgeManager.saveNotifications(existing);

    final count = await NotificationBadgeManager.getNotificationCount();
    await NotificationBadgeManager.setNotificationCount(count + 1);

    // Save pending dialog payload with ALL necessary data
    final payloadData = {
      "building_id": buildingId,
      "name": buildingName,
      "body": body,
      "title": title,
      "timestamp": DateTime.now().toIso8601String(),
    };

    await prefs.setBool('has_pending_notification', true);
    await prefs.setString('pending_notification_data', jsonEncode(payloadData));
    
    log('✅ Background handler saved notification: $payloadData');

    // Show local notification
    await _showLocalNotification(title, body, payloadData);

  } catch (e) {
    log('❌ Background handler error: $e');
  }
}

// Add this method to show local notification
static Future<void> _showLocalNotification(
  String title,
  String body,
  Map<String, dynamic> payload,
) async {
  try {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('beep'),
      enableVibration: true,
      enableLights: true,
      ledColor: Colors.amber,
      ledOnMs: 1000,
      ledOffMs: 500,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction('action_1', 'Yes',
            showsUserInterface: true, cancelNotification: true),
        AndroidNotificationAction('action_2', 'No',
            showsUserInterface: false, cancelNotification: true),
      ],
    );

    const DarwinNotificationDetails iosPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecond,
      title,
      body,
      platformChannelSpecifics,
      payload: jsonEncode(payload),
    );
  } catch (e) {
    log('❌ Error showing local notification: $e');
  }
}

  Future<String> getAccessToken() async {
    final accountCredentials = ServiceAccountCredentials.fromJson(
      jsonDecode(
        await rootBundle.loadString('assets/credentials/service-account.json'),
      ),
    );

    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final httpClient = http.Client();
    AccessCredentials credentials;

    try {
      credentials = await obtainAccessCredentialsViaServiceAccount(
        accountCredentials,
        scopes,
        httpClient,
      );
    } finally {
      httpClient.close();
    }

    return credentials.accessToken.data;
  }

  Future<void> unSubScribeToBuilding(List<String> ids) async {
    if (ids.isNotEmpty) {
      for (String id in ids) {
        await firebaseMessaging.unsubscribeFromTopic('building_$id');
      }
    }
  }

  Future<void> subScribeToBuilding(List<String> ids) async {
    if (ids.isNotEmpty) {
      for (String id in ids) {
        await firebaseMessaging.subscribeToTopic('building_$id');
      }
    }
  }

  @pragma('vm:entry-point')
  static Future<void> initializePlatformSpecifics() async {
    await firebaseMessaging.setAutoInitEnabled(true);
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
      enableLights: true,
      enableVibration: true,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
      showBadge: true,
      ledColor: Colors.amber,
      audioAttributesUsage: AudioAttributesUsage.alarm,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializeIOSSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
      notificationCategories: [
        DarwinNotificationCategory(
          "evac_tracker",
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.plain('action_1', 'Yes'),
            DarwinNotificationAction.plain('action_2', 'No'),
          ],
        ),
      ],
      // onDidReceiveLocalNotification: (id, title, body, payload) async {
      //   log('ios notification on background called');
      //   didReceiveLocalNotificationSubject.add(
      //     ReceivedNotification(
      //       id: id,
      //       title: title ?? "",
      //       body: body ?? "",
      //       payload: payload ?? "",
      //     ),
      //   );
      // },
    );
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializeIOSSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('notificationReceived', false);

            if (notificationResponse.actionId == "action_2") {
              await flutterLocalNotificationsPlugin.cancelAll();
            } else {
              //await flutterLocalNotificationsPlugin.cancelAll();
              if (notificationResponse.id.toString().isNotEmpty) {
                if (router.configuration.navigatorKey.currentContext != null) {
                  showDialog(
                    context: router.configuration.navigatorKey.currentContext!,
                    barrierDismissible: false,
                    builder: (_) => Dialog(
                      backgroundColor: Colors.transparent,
                      child: FireAlertWidget(
                        notificationData: NotificationData(
                          buildingId: jsonDecode(
                            notificationResponse.payload ?? "",
                          )["building_id"].toString(),
                          name: jsonDecode(
                            notificationResponse.payload ?? "",
                          )["name"],
                          dateTime: DateTime.now().toString(),
                          body: jsonDecode(
                            notificationResponse.payload ?? "",
                          )["body"],
                          title: jsonDecode(
                            notificationResponse.payload ?? "",
                          )["title"],
                        ),
                       buildingID: int.tryParse(jsonDecode(notificationResponse.payload ?? "")["building_id"]?.toString() ?? ''),
                        buildingName: jsonDecode(
                          notificationResponse.payload ?? "",
                        )["name"],
                      ),
                    ),
                  );
                  await flutterLocalNotificationsPlugin.cancelAll();
                }
              }
            }
          },
    );
  }

  @pragma('vm:entry-point')
static Future<void> notificationTapBackground(
  NotificationResponse notificationResponse,
) async {
  log('📱 notificationTapBackground STARTED');

  try {
    WidgetsFlutterBinding.ensureInitialized();

    log('📱 Action: ${notificationResponse.actionId}');
    log('📱 Payload: ${notificationResponse.payload}');

    if (notificationResponse.actionId == "action_2") {
      await flutterLocalNotificationsPlugin.cancelAll();
      log('❌ User declined');
      return;
    }

    // User clicked "Yes" or tapped notification
    if (notificationResponse.payload != null &&
        notificationResponse.payload!.isNotEmpty) {
      log('📦 Processing notification payload...');

      final prefs = await SharedPreferences.getInstance();
      
      // Parse the payload to ensure it's valid
      final payloadData = jsonDecode(notificationResponse.payload!);
      
      // Add timestamp if not present
      if (!payloadData.containsKey('timestamp')) {
        payloadData['timestamp'] = DateTime.now().toIso8601String();
      }

      // Save with a special flag for immediate display
      await prefs.setString(
        'pending_notification_data',
        jsonEncode(payloadData),
      );
      await prefs.setBool('has_pending_notification', true);
      await prefs.setBool('show_dialog_immediately', true); // New flag
      await prefs.setString(
        'notification_timestamp',
        DateTime.now().toIso8601String(),
      );

      log('✅ Data saved with immediate display flag');
    }
  } catch (e) {
    log('❌ ERROR in notificationTapBackground: $e');
  }

  log('📱 notificationTapBackground COMPLETED');
}

  static Future<void> _requestIOSPermission() async {
    await firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  void setListenerForLowerVersions(Function onNotificationInLowerVersions) {
    didReceiveLocalNotificationSubject.listen((receivedNotification) {
      onNotificationInLowerVersions(receivedNotification);
    });
  }

  Future<void> onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    // This will handle local notifications for iOS versions below 10.
    // For example, you can show a dialog with the notification details:
    showDialog(
      context: navigatorKey.currentState!.overlay!.context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title ?? 'Notification'),
        content: Text(body ?? ''),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> saveTokenToDatabase(String token, List<String> ids) async {
    log("token: $token");
    final accesstoken = await getAccessToken();
    log('Access Token: $accesstoken'.toString());
    sharedPreference.saveString("firebase_token", token);
    if (ids.isNotEmpty) {
      for (String id in ids) {
        await firebaseMessaging.subscribeToTopic('building_$id');
      }
    }
  }
}
