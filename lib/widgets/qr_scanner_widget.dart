import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Escanear QR"),
      ),
      body: Center(
        child: MobileScanner(
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            for (final barcode in barcodes) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Código QR Detectado"),
                  content: Text('Registro exitoso, bienvenido'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Cerrar"),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
