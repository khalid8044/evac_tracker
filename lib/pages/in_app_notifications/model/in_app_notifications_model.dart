class NotificationData {
  final String buildingId;
  final String name;
  final String body;
  final String title;
  final String dateTime;
  bool shown;

  NotificationData({
    required this.buildingId,
    required this.name,
    required this.dateTime,
    required this.body,
    required this.title,
    this.shown = false,
  });

  // Factory method to create an instance of NotificationData from a JSON map
  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      buildingId: (json['building_id'] is String)
          ? json['building_id'] as String
          : (json['building_id']?.toString() ?? '0'),
      dateTime: json['dateTime'] ?? DateTime.now().toIso8601String(),
      name: json['name'] ?? '',
      body: json['body'] ?? '',
      title: json['title'] ?? '',
      shown: json['shown'] ?? false,
    );
  }

  // Method to convert an instance of NotificationData to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'building_id': buildingId,
      'dateTime': dateTime,
      'name': name,
      'body': body,
      'title': title,
      'shown': shown,
    };
  }

  void markAsShown() {
    shown = true;
  }
}
