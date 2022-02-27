import 'package:flutter/material.dart';
import 'package:esp_touch_flutter_example/ui/components/home_view.dart';
import 'package:esp_touch_flutter_example/ui/components/header_view.dart';
import 'package:esp_touch_flutter_example/ui/components/footer_view.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: HeaderView(),
                    ),
                    Expanded(
                      flex: 3,
                      child: HomeView(),
                    ),
                  ],
                ),
              ),
              Expanded(flex: 1, child: FooterView()),
              Text("© 2022 - VietTran & Anhvietcr")
            ],
          ),
        ),
      ),
    );
  }
}
