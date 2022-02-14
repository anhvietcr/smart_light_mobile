import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_light/core/models/home_model.dart';
import 'package:smart_light/core/utilities/repository.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context);

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.red[700],
        inactiveTrackColor: Colors.red[100],
        trackShape: RoundedRectSliderTrackShape(),
        trackHeight: 6.0,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
        thumbColor: Colors.redAccent,
        overlayColor: Colors.red.withAlpha(32),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
        tickMarkShape: RoundSliderTickMarkShape(),
        activeTickMarkColor: Colors.red[700],
        inactiveTickMarkColor: Colors.red[100],
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: Colors.redAccent,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      child: Slider(
        value: model.currentBrightness,
        min: 0,
        max: 100,
        divisions: 20,
        label: '${model.currentBrightness.toInt()}',
        onChanged: (value) {
          model.changeBrightness(value);
        },
        onChangeEnd: (value) {
          setBrightness(value.toInt());
        },
      ),
    );
  }
}
