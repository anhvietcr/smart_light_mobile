import 'package:flutter/material.dart';

class MusicScreen extends StatefulWidget {
  static const String routeName = "/music";

  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text("music screen"),
        ),
      ),
    );
  }
}
