import 'package:flutter/material.dart';

class QRGeneratorWidget extends StatelessWidget {
  final bool isGeneratingQR;
  final int timeLeft;

  const QRGeneratorWidget({
    Key? key,
    required this.isGeneratingQR,
    required this.timeLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isGeneratingQR
        ? Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.timer, size: 16, color: Colors.grey),
          const SizedBox(width: 4),
          Text(
            'Generando QR: ${timeLeft}s',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    )
        : const SizedBox.shrink();
  }
}
