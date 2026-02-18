
import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';
Future<void> toggleFlashlight(bool isOn) async {
  try {
    if (!isOn) {
      await TorchLight.enableTorch();
    } else {
      await TorchLight.disableTorch();
    }
  } on Exception catch (e) {
    debugPrint('Error: $e');
  }
}

