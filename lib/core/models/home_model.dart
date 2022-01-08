import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_light/core/utilities/enum.dart';
import 'package:smart_light/core/utilities/hex_color.dart';

class HomeModel extends ChangeNotifier {

  /* Core Service*/
  ViewState _state = ViewState.Idle;
  get state => _state;
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  int _selected = -1;
  int get currentIconSelected => _selected;
  void changeIconSelected(index) {
    setState(ViewState.Busy);
    if (_selected == index) {
      _selected = -1;
    } else {
      _selected = index;
    }
    notifyListeners();
  }

  Color _currentColor = HexColor('#FFFFFF');
  Color get currentColor => _currentColor;
  void changeColor(Color color) {
    setState(ViewState.Busy);
    _currentColor = color;
    notifyListeners();
  }

  double _currentBrightness = 0;
  double get currentBrightness => _currentBrightness;
  void changeBrightness(double brightness) {
    setState(ViewState.Busy);
    _currentBrightness = brightness;
    notifyListeners();
  }


  String _localAddress = "139.59.255.148:3500";
  String get localAddress => _localAddress;
  void changeLocalAddress(String address) {
    setState(ViewState.Busy);
    _localAddress = address;
    _currentBrightness = 75;
    notifyListeners();
  }
}
