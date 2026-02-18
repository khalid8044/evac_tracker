import 'package:evac_tracker/components/alerts/fire_alert/fire_alert_widget.dart';
import 'package:evac_tracker/pages/dashboard/notification_manager.dart';
import 'package:evac_tracker/pages/in_app_notifications/model/in_app_notifications_model.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/backend/api_requests/api_calls.dart';
import '/components/header_footer/footer_after_login/footer_after_login_widget.dart';
import '/components/header_footer/header_after_login/header_after_login_widget.dart';
import '/components/page_elements/drawer_content/drawer_content_widget.dart';
import '/components/page_elements/emergency_call/emergency_call_widget.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dashboard_widget.dart' show DashboardWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';

class DashboardModel extends FlutterFlowModel<DashboardWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for drawerContent component.
  late DrawerContentModel drawerContentModel;
  // Model for HeaderAfterLogin component.
  late HeaderAfterLoginModel headerAfterLoginModel;
  // Model for EmergencyCall component.
  late EmergencyCallModel emergencyCallModel;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 60000;
  int timerMilliseconds = 60000;
  String timerValue = StopWatchTimer.getDisplayTime(
    60000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Stores action output result for [Backend Call - API (evacDiagramByID)] action in btnEvacDiagram widget.
  ApiCallResponse? apiResultfeu;
  // Stores action output result for [Backend Call - API (getAssemblyArea)] action in btnAssemblyArea widget.
  ApiCallResponse? apiResultxkn;
  // Stores action output result for [Backend Call - API (getECL)] action in btnEcl widget.
  ApiCallResponse? eclRes;
  // Model for FooterAfterLogin component.
  late FooterAfterLoginModel footerAfterLoginModel;

  @override
  void initState(BuildContext context) {
    drawerContentModel = createModel(context, () => DrawerContentModel());
    headerAfterLoginModel = createModel(context, () => HeaderAfterLoginModel());
    emergencyCallModel = createModel(context, () => EmergencyCallModel());
    footerAfterLoginModel = createModel(context, () => FooterAfterLoginModel());
  }

  @override
  void dispose() {
    drawerContentModel.dispose();
    headerAfterLoginModel.dispose();
    emergencyCallModel.dispose();
    timerController.dispose();
    footerAfterLoginModel.dispose();
  }

  static void _showDialog(
      BuildContext context, NotificationData notificationData) {
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

  // Function to handle what happens when the app is brought to foreground
  void triggerNotificationOnResume(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isNotificationPending = prefs.getBool('notificationReceived') ?? false;
    bool isDialogShown = prefs.getBool('dialogShown') ?? false;

    if (isNotificationPending && !isDialogShown) {
      List<NotificationData> notifications =
          (await NotificationBadgeManager.fetchNotifications())
              .where((notification) => !notification
                  .shown) // Filter only notifications with shown = false
              .toList();

      if (notifications.isNotEmpty) {
        _showDialog(context, notifications.last);

        await flutterLocalNotificationsPlugin.cancelAll();

        FFAppState().isNotification = true;
        await prefs.setBool('notificationReceived', false);
        await prefs.setBool('dialogShown',
            true); // Set the dialogShown flag to prevent multiple triggers

        markNotificationAsShown(notifications.last);
      }
    }
  }

  // Method to mark the last notification as shown
  void markNotificationAsShown(NotificationData notification) async {
    // Mark it as shown
    notification.markAsShown();

    // Fetch all notifications from storage
    List<NotificationData> notifications =
        await NotificationBadgeManager.fetchNotifications();

    // Find the index of the updated notification
    int index = notifications.indexWhere((n) =>
        n.buildingId == notification.buildingId &&
        n.dateTime == notification.dateTime);

    if (index != -1) {
      // Replace the old notification with the updated one
      notifications[index] = notification;

      // Save the updated notifications list back to SharedPreferences or database
      await NotificationBadgeManager.saveNotifications(notifications);
    }
  }
}
