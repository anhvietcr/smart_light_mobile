import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void setColor(Color color, BuildContext context, String hostAddress) async {
  if (hostAddress == "") return;

  try {
    var res = await http.put(
      Uri.http('$hostAddress', '/api/led/color'),
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
  BuildContext context,
  String hostAddress,
) async {
  if (hostAddress == "") return;

  try {
    var res = await http.put(
      Uri.http('$hostAddress', '/api/led/brightness'),
      body: {
        "brightness": brightness.toString(),
      },

      //  headers: {  "Content-type": "text/html"}
    );
  } catch (e) {
    print("error $e");
  }
}
