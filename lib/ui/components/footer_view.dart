import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:esp_touch_flutter_example/core/models/home_model.dart';
import 'package:esp_touch_flutter_example/core/utilities/constants.dart';
import 'package:esp_touch_flutter_example/ui/widgets/widgets.dart';

class FooterView extends StatefulWidget {
  @override
  _FooterViewState createState() => _FooterViewState();
}

class _FooterViewState extends State<FooterView> {
  final List<IconData> icons = [
    Icons.settings,
    Icons.person,
    Icons.ac_unit,
    Icons.notifications_none,
  ];

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context);

    return model.currentIconSelected == 0
        ? Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Độ sáng',
                          style: TextStyles.style.copyWith(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Độ sáng đèn rất quan trọng cho đôi mắt',
                          style: TextStyles.style.copyWith(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey[400],
                          ),
                        ),
                        SizedBox(height: 15.0),
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(Icons.brightness_3),
                      onTap: () {
                        model.changeBrightness(0.0);
                      },
                    ),
                    Expanded(child: CustomSlider()),
                    GestureDetector(
                      child: Icon(Icons.lightbulb_outline),
                      onTap: () {
                        model.changeBrightness(100.0);
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        : Container();
  }
}
