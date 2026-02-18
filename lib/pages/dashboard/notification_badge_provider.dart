import 'package:flutter/material.dart';
import '../in_app_notifications/model/in_app_notifications_model.dart';
import 'notification_manager.dart';

class NotificationBadgeProvider extends ChangeNotifier {
  int _notificationCount = 0;
  List<NotificationData> _notifications = [];

  int get notificationCount => _notificationCount;
  List<NotificationData> get notifications => _notifications;

  NotificationBadgeProvider() {
    _loadNotificationCount();
    _loadNotifications();
  }

  Future<void> _loadNotificationCount() async {
    _notificationCount = await NotificationBadgeManager.getNotificationCount();
    notifyListeners();
  }

  Future<void> _loadNotifications() async {
    _notifications = await NotificationBadgeManager.fetchNotifications();
    notifyListeners();
  }

  Future<void> incrementNotificationCount() async {
    await NotificationBadgeManager.incrementNotificationCount();
    _notificationCount = await NotificationBadgeManager.getNotificationCount();
    notifyListeners();
  }

  Future<void> decrementNotificationCount() async {
    await NotificationBadgeManager.decrementNotificationCount();
    _notificationCount = await NotificationBadgeManager.getNotificationCount();
    notifyListeners();
  }

  Future<void> resetNotificationCount() async {
    await NotificationBadgeManager.clearNotifications();
    await NotificationBadgeManager.resetNotificationCount();
    _notificationCount = 0;
    _notificationCount = 0;
    notifyListeners();
  }

  Future<void> setNotificationCount(int count) async {
    await NotificationBadgeManager.setNotificationCount(count);
    _notificationCount = count;
    notifyListeners();
  }

  Future<void> addNotification(NotificationData notification) async {
    NotificationBadgeManager.saveNotification(notification);
    await incrementNotificationCount();
    _notifications.add(notification);
    notifyListeners();
  }

  Future<void> setFullNotifications(List<NotificationData> notification) async {
    _notifications = notification;
    notifyListeners();
  }

  Future<void> clearNotifications() async {
    _notifications.clear();
    await resetNotificationCount();
    notifyListeners();
  }
}
