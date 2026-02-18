
import 'dart:developer';

import 'package:flutter/services.dart';
class PlatformHelper {
  static const MethodChannel _channel = MethodChannel('platform_build');

  static Future<int?> getBuildSdkVersion() async {
    try {

      final int? sdkVersion = await _channel.invokeMethod('getBuildSdkVersion');
      return sdkVersion;
    } on PlatformException catch (e) {
      log("Failed to get build SDK version: '${e.message}'.");
      return null;
    }
  }
}
