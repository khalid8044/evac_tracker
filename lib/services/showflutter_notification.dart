  import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:evac_tracker/services/notifications_bg.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/alerts/fire_alert/fire_alert_widget.dart';
import '../main.dart';
import '../pages/dashboard/notification_badge_provider.dart';
import '../pages/dashboard/notification_manager.dart';
import '../pages/in_app_notifications/model/in_app_notifications_model.dart';
import 'notification_manager.dart';
import 'shared_preference/shared_preference.dart';

class ShowflutterNotification {
   static SharedPreference sharedPreference = SharedPreference();
static final _player = AudioPlayer(
    handleInterruptions: false,
    androidApplyAudioAttributes: false,
    handleAudioSessionActivation: false,
  );

 static final List<NotificationData> _pendingDialogs = [];
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
static Future<void> showFlutterNotification(RemoteMessage messages) async {
    try {
      log('🎯 Processing FCM notification...');
      log('📦 Full message data: ${messages.data}');
      log('📦 Notification object: ${messages.notification}');

      // Extract data from BOTH places (data and notification)
      Map<String, dynamic> message = messages.data;

      // Try to get data from different possible locations
      String? body = message["body"] ?? messages.notification?.body;
      String? title = message["title"] ?? messages.notification?.title;
      String? buildingIdStr =
          message["building_id"]?.toString() ?? message["id"]?.toString();
      String? buildingName =
          message["building_name"]?.toString() ?? message["name"]?.toString();

      // Debug log what we found
      log('📋 Extracted data:');
      log('   - Body: $body');
      log('   - Title: $title');
      log('   - Building ID: $buildingIdStr');
      log('   - Building Name: $buildingName');

      // Check if we have all required data
      if (body != null &&
          title != null &&
          buildingIdStr != null &&
          buildingName != null) {
        int buildingId = int.tryParse(buildingIdStr) ?? 0;

        showNotifications(body, title, buildingId, buildingName);
      } else {
        // Show fallback notification if data is missing
        log('⚠️ Missing some data, showing fallback notification');

        showNotifications(
          body ?? "New notification received",
          title ?? "Notification",
          int.tryParse(buildingIdStr ?? "0") ?? 0,
          buildingName ?? "Building",
        );
      }
    } catch (e) {
      log('❌ Error in showFlutterNotification: $e');
      log('❌ Stack trace: ${e.toString()}');
    }
  }
  
   static void showNotifications(
    String body,
    String title,
    int id,
    String buildingName, {
    bool repeatNotification = false,
  }) async {
    var vibrationPattern = Int64List(16);

    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1500;
    vibrationPattern[2] = 2000;
    vibrationPattern[3] = 1500;
    vibrationPattern[4] = 2000;
    vibrationPattern[5] = 1500;
    vibrationPattern[4] = 2000;
    vibrationPattern[5] = 1500;
    vibrationPattern[6] = 2000;
    vibrationPattern[7] = 1500;
    vibrationPattern[8] = 2000;
    vibrationPattern[9] = 1500;
    vibrationPattern[10] = 2000;
    vibrationPattern[11] = 1500;
    vibrationPattern[12] = 2000;
    vibrationPattern[13] = 1500;
    vibrationPattern[14] = 2000;
    vibrationPattern[15] = 1500;

    bool isLoggedIn = await _checkUserLoggedIn();

    if (!isLoggedIn) {
      // User is logged out, do not show notifications
      log("User is logged out, skipping notification.");
      List<String> ids = await sharedPreference.readStringList("buildingIds");
      NotificationPlugin firebaseMessaging = NotificationPlugin();
      firebaseMessaging.unSubScribeToBuilding(ids);
      sharedPreference.clearAll();
      return;
    }

    NotificationData notificationData = NotificationData(
      buildingId: id.toString(),
      name: buildingName,
      dateTime: DateTime.now().toString(),
      body: body,
      title: title,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
         NotificationPlugin. channel.id,
          // Random().nextInt(pow(1, 31).toInt()).toString(),
         NotificationPlugin. channel.name,
          channelDescription:NotificationPlugin. channel.description,
          importance: Importance.max,
          vibrationPattern: vibrationPattern,
          autoCancel: false,
          channelShowBadge: true,
          enableVibration: true,
          enableLights: true,
          priority: Priority.high,
          playSound: true,
          actions: [
            const AndroidNotificationAction(
              'action_1',
              'Yes',
              showsUserInterface: true,
            ),
            const AndroidNotificationAction(
              'action_2',
              'No',
              showsUserInterface: true,
            ),
          ],
          color: Colors.green,
          styleInformation: const BigTextStyleInformation(''),
        );

    var iosActions = <DarwinNotificationAction>[
      DarwinNotificationAction.plain(
        'YES_ACTION', // Action identifier (string)
        'Yes', // Button title (string)
        options: <DarwinNotificationActionOption>{
          DarwinNotificationActionOption.foreground,
        },
      ),
      DarwinNotificationAction.plain(
        'NO_ACTION', // Action identifier (string)
        'No', // Button title (string)
        options: <DarwinNotificationActionOption>{
          DarwinNotificationActionOption.foreground,
        },
      ),
    ];

    var iosCategory = DarwinNotificationCategory(
      'YOUR_CATEGORY_ID', // Category identifier
      actions: iosActions,
    );

    DarwinNotificationDetails iosNotificationDetails =
        const DarwinNotificationDetails(
          presentBadge: true,
          presentAlert: true,
          presentBanner: true,
          presentSound: true,
          interruptionLevel: InterruptionLevel.timeSensitive,
          categoryIdentifier: 'YOUR_CATEGORY_ID',
        );

    final DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
          // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
          notificationCategories: <DarwinNotificationCategory>[
            iosCategory, // Register the category with the actions
          ],
        );
 
        InitializationSettings(iOS: iosInitializationSettings);

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
    bool isPeep = await sharedPreference.readBool("isPeep");
    //bool isPeep = await sharedPreference.writeBool(users.isPeep);
    try {
      flutterLocalNotificationsPlugin.cancelAll();
      await flutterLocalNotificationsPlugin.show(
        id,
        title,
        "$body. Are you in the building?",
        notificationDetails,
        payload: jsonEncode({
          "building_id": id,
          "name": buildingName,
          "body": body,
          "title": title,
        }),
      );
      await NotificationManager.saveNotificationPayload(
        jsonEncode({
          "building_id": id,
          "name": buildingName,
          "body": body,
          "title": title,
        }),
      );
      log('ios push received');
    } catch (e) {
      log('ios push received$e');
    }

    if (!repeatNotification) {
      if (router.configuration.navigatorKey.currentContext != null) {
        final notificationProvider = Provider.of<NotificationBadgeProvider>(
          router.configuration.navigatorKey.currentContext!,
          listen: false,
        );
        await notificationProvider.addNotification(
          NotificationData(
            buildingId: id.toString(),
            dateTime: DateTime.now().toString(),
            body: body,
            title: title,
            name: buildingName,
          ),
        );
      } else {
        int count = await NotificationBadgeManager.getNotificationCount();
        await NotificationBadgeManager.saveNotification(
          NotificationData(
            buildingId: id.toString(),
            dateTime: DateTime.now().toString(),
            body: body,
            title: title,
            name: buildingName,
          ),
        );
        await NotificationBadgeManager.setNotificationCount(count + 1);
      }
    }

    try {
      if (isPeep) {
        await _player.setAsset("assets/audios/fire.mp3");
        await _player.play();
      } else {
        await _player.setAsset("assets/audios/beep.wav");
        await _player.play();
      }
    } catch (e) {
      log("Error loading or playing audio: $e");
    }

    if (!repeatNotification) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('notificationReceived', true);
      //FFAppState().isNotification = false;
      log(prefs.getBool('notificationReceived').toString());
      Future.delayed(const Duration(milliseconds: 100), () {
        if (router.configuration.navigatorKey.currentContext != null) {
          _showDialog(
            router.configuration.navigatorKey.currentContext!,
            notificationData,
          );
        } else {
          // Queue the dialog to be shown later
          queueDialog(notificationData);
        }
      });
    }
  }

 static void queueDialog(NotificationData notificationData) {
    _pendingDialogs.clear();
    _pendingDialogs.add(notificationData);
  }

  static void _showDialog(
    BuildContext context,
    NotificationData notificationData,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: FireAlertWidget(
          notificationData: notificationData,
          buildingID: int.tryParse(notificationData.buildingId),
          buildingName: notificationData.name,
        ),
      ),
    );
  }
  
  static Future<bool> _checkUserLoggedIn() async {
    // Check if the user is logged in (this is just an example)
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('_auth_authentication_token_');
    log('toek:at notifiction:$authToken');
    //int authToken = FFAppState().user.uid;
    return authToken != '';
  }
  }