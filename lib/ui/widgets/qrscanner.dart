import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_light/ui/screens/screens.dart';
import 'package:wifi_iot/wifi_iot.dart';

class QRScanner extends StatefulWidget {
  final ValueChanged<String> onvalueChanged;
  QRScanner({required this.onvalueChanged});
  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  Barcode? result;
  String resultext = "";
  bool firsttime = true;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildQrView(context),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        resultext = '${scanData.code}';
        result = scanData;
      });

      //logic

      if (firsttime) {
        widget.onvalueChanged('${scanData.code}');
        // Navigator.pop(context);

        String resultQrcode = scanData.code ?? "";
        String ssid = resultQrcode.trim().split('-')[0];
        String pwd = resultQrcode.trim().split('-')[1];

        await WiFiForIoTPlugin.removeWifiNetwork('$ssid');
        var isConnected = await WiFiForIoTPlugin.connect(
          "$ssid",
          password: "$pwd",
          security: NetworkSecurity.WPA,
          withInternet: true,
        );
        // await WiFiForIoTPlugin.registerWifiNetwork(ssid, password: pwd, security: NetworkSecurity.WPA);

        await WiFiForIoTPlugin.forceWifiUsage(true);

        print("isConnected $isConnected");
        if (isConnected) {
          Navigator.of(context).pushNamed(WifiScreen.routeName);
        }

        setState(() {
          firsttime = false;
        });
      }
    });
  }

  Future<List<WifiNetwork>> loadWifiList() async {
    List<WifiNetwork> htResultNetwork;
    try {
      htResultNetwork = await WiFiForIoTPlugin.loadWifiList();
    } on PlatformException {
      htResultNetwork = List<WifiNetwork>.empty();
    }

    return htResultNetwork;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
