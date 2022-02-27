import 'package:flutter/material.dart';
import "package:flutter/widgets.dart";
import 'ui/screens/screens.dart';

Route onGenerateRoute(RouteSettings settings) {
  Widget widget;
  switch (settings.name) {
    case WifiScreen.routeName:
      widget = WifiScreen();
      break;
    case MusicScreen.routeName:
      widget = MusicScreen();
      break;
    default:
      widget = HomeScreen();
  }
  return MaterialPageRoute(builder: (context) => widget);
}
