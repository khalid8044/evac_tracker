import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class MobileScanScreen extends StatefulWidget {
  const MobileScanScreen({super.key});

  @override
  State<MobileScanScreen> createState() => _MobileScanScreenState();
}

class _MobileScanScreenState extends State<MobileScanScreen> {
  MobileScannerController controller = MobileScannerController();

  bool _scanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => controller.toggleTorch(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: controller,
        useAppLifecycleState: false,
        onDetect: (capture) {
          if (_scanned) return;

          final barcode = capture.barcodes.first;
          final String? code = barcode.rawValue;

          if (code != null) {
            _scanned = true;
            Navigator.pop(context, code); // Return scanned result
          }
        },
      ),
    );
  }
}
