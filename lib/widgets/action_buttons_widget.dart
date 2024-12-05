import 'package:flutter/material.dart';

class ActionButtonsWidget extends StatelessWidget {
  final bool isScanning;
  final bool isGeneratingQR;
  final VoidCallback onStartScanning;
  final VoidCallback onStartGeneratingQR;

  const ActionButtonsWidget({
    Key? key,
    required this.isScanning,
    required this.isGeneratingQR,
    required this.onStartScanning,
    required this.onStartGeneratingQR,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: isScanning ? null : onStartScanning,
          child: Text(isScanning ? 'Escaneando...' : 'Escanear QR'),
        ),
        ElevatedButton(
          onPressed: isGeneratingQR ? null : onStartGeneratingQR,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(color: Colors.blue),
          ),
          child: Text(isGeneratingQR ? 'Generando QR...' : 'Generar QR'),
        ),
      ],
    );
  }
}
