import 'package:flutter/material.dart';
import 'package:qrexample/widgets/generate_qr_widget.dart';
import 'package:qrexample/widgets/qr_scanner_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seleccionar Acción"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GenerateQRScreen()),
                );
              },
              child: const Text("Generar QR"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QRScannerScreen()),
                );
              },
              child: const Text("Escanear QR"),
            ),
          ],
        ),
      ),
    );
  }
}
