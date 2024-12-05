import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrexample/widgets/action_buttons_widget.dart';
import 'package:qrexample/widgets/qr_generator_widget.dart';
import 'package:qrexample/widgets/qr_scanner_widget.dart';
import 'package:qrexample/widgets/result_display_widget.dart';
import 'dart:async';


class QRReaderPage extends StatefulWidget {
  const QRReaderPage({Key? key}) : super(key: key);

  @override
  _QRReaderPageState createState() => _QRReaderPageState();
}

class _QRReaderPageState extends State<QRReaderPage> {
  MobileScannerController cameraController = MobileScannerController();
  bool isScanning = false;
  bool isGeneratingQR = false;
  int timeLeft = 30;
  Timer? _timer;
  String qrResult = '';

  @override
  void dispose() {
    cameraController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _resetState() {
    setState(() {
      isScanning = false;
      isGeneratingQR = false;
      qrResult = '';
      _timer?.cancel();
    });
  }

  void _startScanning() {
    setState(() {
      isScanning = true;
      qrResult = '';
    });
  }

  void _startGeneratingQR() {
    setState(() {
      isGeneratingQR = true;
      timeLeft = 30;
      qrResult = '';
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          _stopGeneratingQR();
        }
      });
    });
    Future.delayed(const Duration(seconds: 30), () {
      setState(() {
        qrResult = 'Generated QR Code Data';
        _stopGeneratingQR();
      });
    });
  }

  void _stopGeneratingQR() {
    setState(() {
      isGeneratingQR = false;
      _timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ingreso por QR"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Restablece el estado al inicial y regresa a la pantalla anterior.
            _resetState();
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
              maxHeight: 800,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QRScannerWidget(
                    isScanning: isScanning,
                    cameraController: cameraController,
                    onDetect: (value) {
                      setState(() {
                        qrResult = value;
                        isScanning = false;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  ActionButtonsWidget(
                    isScanning: isScanning,
                    isGeneratingQR: isGeneratingQR,
                    onStartScanning: _startScanning,
                    onStartGeneratingQR: _startGeneratingQR,
                  ),
                  QRGeneratorWidget(
                    isGeneratingQR: isGeneratingQR,
                    timeLeft: timeLeft,
                  ),
                  ResultDisplayWidget(qrResult: qrResult),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
