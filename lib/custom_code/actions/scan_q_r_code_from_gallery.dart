import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:flutter/material.dart';

Future<String?> scanQRCodeFromGallery(BuildContext context) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile == null) {
    print('No image selected.');
    return null;
  }

  final inputImage = InputImage.fromFile(File(pickedFile.path));
  final barcodeScanner = BarcodeScanner();

  try {
    final List<Barcode> barcodes = await barcodeScanner.processImage(inputImage);
    await barcodeScanner.close();

    if (barcodes.isNotEmpty) {
      return barcodes.first.rawValue;
    } else {
      print('No QR code found.');
      return null;
    }
  } catch (e) {
    print('Error while scanning QR code: $e');
    return null;
  }
}
