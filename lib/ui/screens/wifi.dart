import 'package:flutter/material.dart';
import 'package:smart_light/core/models/wifi.dart';
import 'package:smart_light/core/utilities/repository.dart';
import 'package:smart_light/ui/screens/home.dart';

class WifiScreen extends StatefulWidget {
  static const String routeName = "/wifi";

  @override
  _WifiScreenState createState() => _WifiScreenState();
}

class _WifiScreenState extends State<WifiScreen> {
  final ssidController = TextEditingController();
  final pwdController = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var items = [];

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Danh sách WIFI"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder<List<Wifi>>(
        future: getWifi(),
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
                          margin: const EdgeInsets.symmetric(horizontal: 50),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              /// SSID
                              TextField(
                                controller: ssidController,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none,
                                    hintText: 'SSID',
                                    isCollapsed: false,
                                    hintStyle: TextStyle(
                                        fontSize: 14, color: Colors.grey)),
                              ),
                              Divider(color: Colors.black54, height: 1),

                              /// PASSWORD
                              TextField(
                                controller: pwdController,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none,
                                    hintText: 'Mật khẩu',
                                    isCollapsed: false,
                                    hintStyle: TextStyle(
                                        fontSize: 14, color: Colors.grey)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 35),

                        /// LOGIN BUTTON
                        MaterialButton(
                          onPressed: () {
                            if (ssidController.text == "") {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text("Vui lòng chọn WIFI muốn kết nối"),
                              ));
                            }
                            getWifiSave(
                              ssidController.text,
                              pwdController.text,
                            );

                            Navigator.of(context)
                                .pushNamed(HomeScreen.routeName);
                          },
                          height: 45,
                          minWidth: 240,
                          child: const Text(
                            'Kết nối',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          textColor: Colors.white,
                          color: Colors.green.shade700,
                          shape: const StadiumBorder(),
                        )
                      ],
                    ),
                  );
                }

                return Card(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        ssidController.text = items[idx].ssid;
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
                              icon: new Icon(items[idx].quantity >= 50
                                  ? Icons.wifi
                                  : Icons.signal_wifi_0_bar_rounded),
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
    );
  }
}
