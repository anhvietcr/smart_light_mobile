import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_light/core/models/wifi.dart';

String _hostAddress = "139.59.255.148:3500";
String _espAddress = "192.168.4.1";

Dio get dio {
  return Dio(BaseOptions());
}

void setColor(Color color) async {
  try {
    await http.put(
      Uri.http('$_hostAddress', '/api/led/color'),
      body: {
        "red": color.red.toString(),
        "green": color.green.toString(),
        "blue": color.blue.toString()
      },

      //  headers: {  "Content-type": "text/html"}
    );
  } catch (e) {
    print("error $e");
  }
}

void setBrightness(
  int brightness,
) async {
  try {
    await http.put(
      Uri.http('$_hostAddress', '/api/led/brightness'),
      body: {
        "brightness": brightness.toString(),
      },

      //  headers: {  "Content-type": "text/html"}
    );
  } catch (e) {
    print("error $e");
  }
}

Future<List<Wifi>> getWifi() async {
  try {
    http.Response response = await http.get(Uri.http('$_espAddress', '/wifi'));
    // Response response = await dio.get(
    //   'http://192.168.4.1/wifi',
    // );
    // dio.clear();
    // dio.close();

    List<Wifi> listWifi = [];

    if (response.statusCode == 200) {
      listWifi
        .add(Wifi.fromJson({"ssid": response.body, "signalQuantity": "100"}));
      listWifi
        .add(Wifi.fromJson({"ssid": json.decode(response.body), "signalQuantity": "100"}));
    // if (json.decode(response.body.) != null) {
    //   response.body['data'].forEach((v) {
    //     listWifi.add(Wifi.fromJson(v));
    //   });
    // }
    }
    else {
      listWifi.add(Wifi.fromJson(
          {"ssid": "Không tìm thấy danh sách", "signalQuantity": "0"}));
    }

    // var d = [
    //   {"ssid": "Viettran 2.4G", "signalQuantity": "100"},
    //   {"ssid": "VNPT-Van Thuyen", "signalQuantity": "38"},
    //   {"ssid": "VNPT-Quynh nhu", "signalQuantity": "28"}
    // ];
    // d.forEach((element) {
    //   listWifi.add(Wifi.fromJson(element));
    // });

    // if (response.data["data"] == null) {
    //   listWifi.add(Wifi.fromJson(
    //       {"ssid": "Không tìm thấy danh sách", "signalQuantity": "0"}));
    //   return listWifi;
    // }

    // listWifi
    //     .add(Wifi.fromJson({"ssid": response.data, "signalQuantity": "100"}));
    // if (response.data['data'] != null) {
    //   response.data['data'].forEach((v) {
    //     listWifi.add(Wifi.fromJson(v));
    //   });
    // }
    return listWifi;
  } on DioError catch (e) {
    print("error $e");
    List<Wifi> listWifi = [];

    listWifi.add(Wifi.fromJson({"ssid": "Lỗi kết nối", "signalQuantity": "0"}));
    listWifi.add(Wifi.fromJson({"ssid": e.message, "signalQuantity": "0"}));
    return listWifi;
  } catch (e) {
    print("error $e");
    List<Wifi> listWifi = [];

    listWifi.add(
        Wifi.fromJson({"ssid": "Lỗi kết nối - catch", "signalQuantity": 0}));
    listWifi.add(Wifi.fromJson({"ssid": e, "signalQuantity": 0}));
    return listWifi;
  }
}

Future<bool> getWifiSave(String ssid, String pwd) async {
  try {
    Response response = await dio.get(
      'http://192.168.4.1/wifisave',
      queryParameters: {
        "s": ssid,
        "p": pwd,
      },
    );
    dio.clear();
    dio.close();

    return true;
  } catch (e) {
    print("error $e");
    return false;
  }
}
