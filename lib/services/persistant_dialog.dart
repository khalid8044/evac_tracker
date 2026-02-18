import 'dart:developer';

import 'package:flutter/material.dart';

import '../components/alerts/fire_alert/fire_alert_widget.dart';
import '../pages/in_app_notifications/model/in_app_notifications_model.dart';

class PersistentDialogManager {
  static bool _isDialogShowing = false;
  static BuildContext? _dialogContext;

  static bool get isDialogShowing => _isDialogShowing;

  static void showPersistentDialog(
    BuildContext context,
    Map<String, dynamic> data,
  ) {
    if (_isDialogShowing) {
      log('⚠️ Dialog already showing, updating content if needed');
      // Optionally update existing dialog content
      return;
    }

    _isDialogShowing = true;
    _dialogContext = context;

    showDialog(
      context: context,
      barrierDismissible: false, // Important: prevents tap outside to dismiss
      builder: (BuildContext dialogContext) {
        return WillPopScope(
          onWillPop: () async {
            // Prevent back button from dismissing
            return false;
          },
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: FireAlertWidget(
              notificationData: NotificationData(
                buildingId: data["building_id"].toString(),
                name: data["name"]?.toString() ?? 'Unknown',
                dateTime: data["timestamp"] ?? DateTime.now().toString(),
                body: data["body"]?.toString() ?? '',
                title: data["title"]?.toString() ?? 'Notification',
              ),
              buildingID: int.tryParse(data["building_id"].toString()),
              buildingName: data["name"]?.toString() ?? 'Unknown',
              
            ),
          ),
        );
      },
    ).then((_) {
      // Dialog was closed
      _isDialogShowing = false;
      _dialogContext = null;
      log('✅ Dialog closed');
    });
  }

  static void dismissDialog() {
    if (_isDialogShowing && _dialogContext != null) {
      Navigator.of(_dialogContext!).pop();
      _isDialogShowing = false;
      _dialogContext = null;
    }
  }
}