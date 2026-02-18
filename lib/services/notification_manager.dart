import 'package:evac_tracker/components/alerts/fire_alert/fire_alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../pages/in_app_notifications/model/in_app_notifications_model.dart';

class NotificationManager {
  static Future<void> handleNotification(BuildContext context) async {
    // Check if there's a pending notification
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? payload = prefs.getString('notification_payload');

    if (payload != null) {
      final notificationData = jsonDecode(payload);

      // Show the dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Dialog(
          backgroundColor: Colors.transparent,
          child: FireAlertWidget(
            notificationData: NotificationData(
              buildingId: notificationData["building_id"],
              name: notificationData["name"],
              dateTime: DateTime.now().toString(),
              body: notificationData["body"],
              title: notificationData["title"],
            ),
            buildingID: int.tryParse(notificationData["building_id"]??''),
            buildingName: notificationData["name"],
          ),
        ),
      );

      // Clear the notification payload
      await prefs.remove('notification_payload');
    }
  }

  static Future<void> saveNotificationPayload(String payload) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('notification_payload', payload);
  }
}
