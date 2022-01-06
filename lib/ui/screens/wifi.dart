import 'package:flutter/material.dart';

class WifiScreen extends StatefulWidget {
  static const String routeName = "/wifi";

  @override
  _WifiScreenState createState() => _WifiScreenState();
}

class _WifiScreenState extends State<WifiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text("wifi screen"),
        ),
      ),
    );
  }
}
