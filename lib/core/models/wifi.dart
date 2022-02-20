class Wifi {
  late String ssid;
  late String quantity;

  Wifi({
    required this.ssid,
    required this.quantity,
  });

  Wifi.fromJson(Map<String, dynamic> json) {
    ssid = json['ssid'] ?? "#";
    quantity = json['signalQuantity'] ?? "0";
  }
}
