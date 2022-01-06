import 'package:flutter/material.dart';

class SmartLightColors {
  static Color primary = new Color(0xff015da6); //0056b8
}

class TextStyles {
  static TextStyle style =
      TextStyle(color: SmartLightColors.primary, fontFamily: 'Montserrat');
}

class Service {
  Service({
    required this.name,
    required this.icon,
    this.status = false,
  });
  String name;
  IconData icon;
  bool status;

  static List<Service> getHomeService() {
    List<Service> services = [
      Service(name: 'Độ sáng', icon: Icons.lightbulb_outline),
      Service(name: 'Kết nối', icon: Icons.wifi, status: true),
      Service(name: 'Màu sắc', icon: Icons.color_lens),
      Service(name: 'Âm thanh', icon: Icons.music_note_outlined),
    ];
    return services;
  }
}