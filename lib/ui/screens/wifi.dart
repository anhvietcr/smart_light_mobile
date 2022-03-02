import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:esp_touch_flutter_example/core/models/home_model.dart';

class WifiScreen extends StatefulWidget {
  final ValueChanged<String> onvalueChanged;
  static const String routeName = "/wifi";
  WifiScreen({Key key, this.onvalueChanged}) : super(key: key);

  @override
  _WifiScreenState createState() => _WifiScreenState();
}

class _WifiScreenState extends State<WifiScreen> {
  static const platform = const MethodChannel('samples.flutter.io/esptouch');

  final TextEditingController _bssidFilter = new TextEditingController();
  final TextEditingController _ssidFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();

  bool _isLoading = false;

  String _msg = "";

  Future<void> _configureEsp({ssid, bssid, password}) async {
    String output = "";

    setState(() {
      _isLoading = true;
    });

    try {
      // Change if required.
      const String deviceCount = "1"; //  the expect result count
      const String broadcast = "1"; // broadcast or multicast
      const Duration _kLongTimeout = const Duration(seconds: 20);

      final String result =
          await platform.invokeMethod('startSmartConfig', <String, dynamic>{
        'ssid': ssid,
        'bssid': bssid,
        'pass': password,
        'deviceCount': deviceCount,
        'broadcast': broadcast,
      }).timeout(_kLongTimeout);

      final parsed = json.decode(result);
      final devices = parsed["devices"];

      output = "Following devices configured: \n\n";

      for (var device in devices) {
        output += "bssid: ${device["bssid"]} ip: ${device["ip"]} \n";
      }

      _msg = output;
    } on PlatformException catch (e) {
      output = "Failed to configure: '${e.message}'.";
    }

    widget.onvalueChanged('192.168.4.1');

    setState(() {
      _isLoading = false;
      _msg = output;
    });
  }

  Future<List<WifiNetwork>> loadWifiList() async {
    List<WifiNetwork> htResultNetwork;

    print("waiting...");
    try {
      htResultNetwork = await WiFiForIoTPlugin.loadWifiList();
    } catch (e) {
      htResultNetwork = <WifiNetwork>[];
    }
    return htResultNetwork;
  }

  _displaySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    var items = [];
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Danh sách WIFI"),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                setState(() {});
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: _isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue),
                  ),
                ),
                color: Colors.white.withOpacity(0.8),
              )
            : FutureBuilder<List<WifiNetwork>>(
                future: loadWifiList(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  items = snapshot.data ?? [];

                  return Container(
                    child: ListView.builder(
                      itemCount: items.length + 1,
                      itemBuilder: (context, idx) {
                        if (idx == items.length) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 35),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 50),
                                  height: 120,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            blurRadius: 20,
                                            spreadRadius: 10,
                                            offset: const Offset(0, 10)),
                                      ]),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      /// SSID
                                      TextField(
                                        controller: _ssidFilter,
                                        style: TextStyle(fontSize: 15),
                                        decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: InputBorder.none,
                                            hintText: 'SSID',
                                            isCollapsed: false,
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey)),
                                      ),
                                      Divider(color: Colors.black54, height: 1),

                                      /// PASSWORD
                                      TextField(
                                        controller: _passwordFilter,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: InputBorder.none,
                                            hintText: 'Mật khẩu',
                                            isCollapsed: false,
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey)),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 35),

                                /// LOGIN BUTTON
                                MaterialButton(
                                  onPressed: () {
                                    if (_ssidFilter.text == "") {
                                      _displaySnackBar(context,
                                          'Vui lòng chọn WIFI muốn kết nối');
                                    } else {
                                      _configureEsp(
                                        ssid: _ssidFilter.text,
                                        password: _passwordFilter.text,
                                        bssid: _bssidFilter.text,
                                      );
                                    }
                                  },
                                  height: 45,
                                  minWidth: 240,
                                  child: const Text(
                                    'Kết nối',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  textColor: Colors.white,
                                  color: Colors.green.shade700,
                                  shape: const StadiumBorder(),
                                ),
                                new Container(height: 10),
                                Text(_msg),
                              ],
                            ),
                          );
                        }

                        return Card(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _ssidFilter.text = items[idx].ssid;
                                _bssidFilter.text = items[idx].bssid;
                              });
                            },
                            child: new ListTile(
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  items[idx].ssid,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                              trailing: new Column(
                                children: <Widget>[
                                  new IconButton(
                                      icon: new Icon(items[idx].level >= 80
                                          ? Icons.wifi
                                          : Icons.network_wifi),
                                      onPressed: () {}),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
