class FCMModel {
  FCMNotification? notification;
  String? priority;
  String? sound;
  FCMData? data;
  String? to;
  APNSNotification? apnsNotification;

  FCMModel({
    this.notification,
    this.priority,
    this.sound,
    this.data,
    this.to,
    this.apnsNotification,
  });

  FCMModel.fromJson(Map<String, dynamic> json) {
    notification = json['notification'] != null
        ? FCMNotification.fromJson(json['notification'])
        : null;
    priority = json['priority'].toString();
    sound = json['sound'];
    data = json['data'] != null ? FCMData.fromJson(json['data']) : null;
    to = json['to'];
    apnsNotification = json['apns'] != null
        ? APNSNotification.fromJson(json['apns'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notification != null) {
      data['notification'] = notification!.toJson();
    }
    data['priority'] = priority;
    data['sound'] = sound;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['to'] = to;
    if (apnsNotification != null) {
      data['apns'] = apnsNotification!.toJson();
    }
    return data;
  }
}

class FCMNotification {
  String? body;
  String? title;
  String? sound;
  String? priority;

  FCMNotification({this.body, this.title, this.sound, this.priority});

  FCMNotification.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    title = json['title'];
    sound = json['sound'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['body'] = body;
    data['title'] = title;
    data['sound'] = sound;
    data['priority'] = priority;
    return data;
  }
}

class FCMData {
  String? clickAction;
  String? id;
  String? body;
  String? title;
  String? status;

  FCMData({this.clickAction, this.id, this.body, this.title, this.status});

  FCMData.fromJson(Map<String, dynamic> json) {
    clickAction = json['click_action'];
    id = json['id'];
    body = json['body'];
    title = json['title'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['click_action'] = clickAction;
    data['id'] = id;
    data['body'] = body;
    data['title'] = title;
    data['status'] = status;
    return data;
  }
}

class APNSNotification {
  APNSPayload? payload;

  APNSNotification({this.payload});

  APNSNotification.fromJson(Map<String, dynamic> json) {
    payload = json['payload'] != null ? APNSPayload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    return data;
  }
}

class APNSPayload {
  APNSAps? aps;

  APNSPayload({this.aps});

  APNSPayload.fromJson(Map<String, dynamic> json) {
    aps = json['aps'] != null ? APNSAps.fromJson(json['aps']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (aps != null) {
      data['aps'] = aps!.toJson();
    }
    return data;
  }
}

class APNSAps {
  String? sound;

  APNSAps({this.sound});

  APNSAps.fromJson(Map<String, dynamic> json) {
    sound = json['sound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sound'] = sound;
    return data;
  }
}
class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}