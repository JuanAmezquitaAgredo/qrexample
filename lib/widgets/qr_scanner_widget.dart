import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerWidget extends StatelessWidget {
  final bool isScanning;
  final MobileScannerController cameraController;
  final Function(String) onDetect;

  const QRScannerWidget({
    Key? key,
    required this.isScanning,
    required this.cameraController,
    required this.onDetect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: isScanning
              ? MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                onDetect(barcode.rawValue ?? 'Código QR no reconocido');
              }
            },
          )
              : Center(
            child: Icon(
              Icons.qr_code,
              size: 80,
              color: Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }
}
