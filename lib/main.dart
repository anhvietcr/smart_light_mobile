import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_light/ui/screens/home.dart';
import 'package:smart_light/core/models/home_model.dart';
import 'package:smart_light/core/utilities/hex_color.dart';
import 'package:flutter/services.dart';
import 'nav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ChangeNotifierProvider(
      create: (context) => HomeModel(),
      child: MaterialApp(
        onGenerateRoute: onGenerateRoute,
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        theme: ThemeData(
          backgroundColor: HexColor('#E2EDF8'),
          primaryColor: HexColor('#E2EDF8'),
          scaffoldBackgroundColor: HexColor('#E2EDF8'),
        ),
      ),
    );
  }
}
