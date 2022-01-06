import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class HSVColorPicker extends StatefulWidget {
  const HSVColorPicker({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    this.colorHistory,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color>? colorHistory;

  @override
  State<HSVColorPicker> createState() => _HSVColorPickerState();
}

class _HSVColorPickerState extends State<HSVColorPicker> {
  // Picker
  PaletteType _paletteType = PaletteType.hueWheel;
  bool _enableAlpha = false;
  bool _displayThumbColor = true;
  bool _displayHexInputBar = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          child: Text("Đồng ý"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: Theme.of(context).primaryColor,
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: widget.pickerColor,
          onColorChanged: widget.onColorChanged,
          colorPickerWidth: MediaQuery.of(context).size.width,
          pickerAreaHeightPercent: 0.7,
          enableAlpha: _enableAlpha,
          labelTypes: [],
          displayThumbColor: _displayThumbColor,
          paletteType: _paletteType,
          hexInputBar: _displayHexInputBar,
        ),
      ),
    );
  }
}
