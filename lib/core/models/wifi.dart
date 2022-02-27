class Wifi {
  String ssid;
  String quantity;

  Wifi({
    this.ssid,
    this.quantity,
  });

  Wifi.fromJson(Map<String, dynamic> json) {
    ssid = json['ssid'] ?? "#";
    quantity = json['signalQuantity'] ?? "0";
  }
}
