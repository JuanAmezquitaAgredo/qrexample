import 'package:flutter/material.dart';

class ResultDisplayWidget extends StatelessWidget {
  final String qrResult;

  const ResultDisplayWidget({
    Key? key,
    required this.qrResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return qrResult.isNotEmpty
        ? Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        'Resultado: $qrResult',
        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        textAlign: TextAlign.center,
      ),
    )
        : const SizedBox.shrink();
  }
}
