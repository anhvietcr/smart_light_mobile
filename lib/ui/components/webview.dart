import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewWifi extends StatefulWidget {
  static const String routeName = "/webview_wifi";

  @override
  WebviewWifiState createState() => WebviewWifiState();
}

class WebviewWifiState extends State<WebviewWifi> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://wifi.xxx',
    );
  }
}
