import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:otp/otp.dart';

class GenerateQRScreen extends StatefulWidget {
  const GenerateQRScreen({Key? key}) : super(key: key);

  @override
  _GenerateQRScreenState createState() => _GenerateQRScreenState();
}

class _GenerateQRScreenState extends State<GenerateQRScreen> {
  late Timer _timer;
  String _qrData = '';
  String qrMessage = 'Generando QR...';
  int timeLeft = 20; // Tiempo de expiración del QR
  final String userId = "sebas1913";
  final String otpSecret = "HI893Y23B234H9823Y984Y23H4HJK23HJ4HKJ23HIU4H9283Y4932";

  @override
  void initState() {
    super.initState();
    _generateQRData();
    _startQRUpdateTimer();
  }

  void _generateQRData() {
    String otp = OTP.generateTOTPCodeString(
      otpSecret,
      DateTime.now().millisecondsSinceEpoch,
      interval: 5, // Duración
    );

    Map<String, dynamic> userData = {
      "user": userId,
      "type": "QR",
      "otp": otp,
    };

    setState(() {
      _qrData = jsonEncode(userData);
      qrMessage = 'QR generado: $otp'; // Mensaje para mostrar el OTP generado
    });
  }

  void _startQRUpdateTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          qrMessage = 'QR expirado';
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generar QR"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_qrData.isNotEmpty)
              QrImageView(
                data: _qrData,
                version: QrVersions.auto,
                size: 260.0,
                backgroundColor: Colors.white,
              ),
            const SizedBox(height: 16),
            Text(qrMessage),
            if (timeLeft > 0)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Expira en: $timeLeft segundos',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
