import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

import '../in_app_notifications/model/in_app_notifications_model.dart';

class NotificationBadgeManager {
  static const String _notificationCountKey = 'notification_count';
  static const String _notificationsListKey = 'notification';

  static Future<int> getNotificationCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt(_notificationCountKey) ?? 0;
  }

  static Future<void> incrementNotificationCount() async {
    int currentCount = await getNotificationCount();
    log('message increment called');
    await setNotificationCount(currentCount + 1);
  }

  static Future<void> decrementNotificationCount() async {
    int currentCount = await getNotificationCount();
    if (currentCount > 0) {
      await setNotificationCount(currentCount - 1);
    }
  }

  static Future<void> setNotificationCount(int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_notificationCountKey, count);
  }

  static Future<void> resetNotificationCount() async {
    await setNotificationCount(0);
  }

  static Future<void> saveNotification(NotificationData notification) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notifications =
        prefs.getStringList(_notificationsListKey) ?? [];
    notifications.add(jsonEncode(notification.toJson()));
    print("in save notification: ${notifications.length}");

    await prefs.setStringList(_notificationsListKey, notifications);
  }

  static Future<List<NotificationData>> fetchNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    List<String> notifications =
        prefs.getStringList(_notificationsListKey) ?? [];

    return notifications
        .map((notification) =>
            NotificationData.fromJson(jsonDecode(notification)))
        .toList();
  }

  static Future<void> clearNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_notificationsListKey);
  }

  static Future<void> saveNotifications(
      List<NotificationData> notifications) async {
        log('called for saving${notifications.length}');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert the notifications to JSON strings
    List<String> notificationsJson = notifications
        .map((notification) => jsonEncode(notification.toJson()))
        .toList();

    // Save the JSON strings list to SharedPreferences
    await prefs.setStringList(_notificationsListKey, notificationsJson);
  }
}
