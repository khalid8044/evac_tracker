import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'fcm_model.dart';

class SendFcm {
   static Future<void> sendNotificationFCM(
    String token,
    String title,
    String body,
  ) async {
    FCMData data;
    FCMModel fcmModel;
    if (Platform.isAndroid) {
      data = FCMData(
        id: "1",
        status: "done",
        title: title,
        body: body,
        clickAction: "FLUTTER_NOTIFICATION_CLICK",
      );
      fcmModel = FCMModel(priority: "high", data: data, to: token);
    } else {
      data = FCMData(
        id: "1",
        status: "done",
        clickAction: "FLUTTER_NOTIFICATION_CLICK",
      );
      FCMNotification notification = FCMNotification(title: title, body: body);
      fcmModel = FCMModel(
        priority: "high",
        data: data,
        to: token,
        notification: notification,
      );
    }
    if (kDebugMode) {
      log("im in fcm $body");
    }
    if (kDebugMode) {
      log(jsonEncode(fcmModel));
    }
    final response = await http
        .post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer AAAAtLMfoU8:APA91bGNKD-YjlljGwYO6IQCc1jm5YHDbm_PbQk72HWaDtJ-YCw0r0JSOFPzXlQ93z_9dJnDfq0-NC1eh_vFYYnZKU5LWH7hQ2OJxJG9UwvTS5rRwNvBE0MYYClO6HNbAU9I3VIW_7wQ',
          },
          body: jsonEncode(fcmModel),
        )
        .catchError((error, stackTrace) {
          throw error;
        });
    log(response.statusCode.toString());
  }
}