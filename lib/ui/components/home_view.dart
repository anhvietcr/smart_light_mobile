import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_light/core/models/home_model.dart';
import 'package:smart_light/core/utilities/constants.dart';
import 'package:smart_light/core/utilities/repository.dart';
import 'package:smart_light/ui/screens/screens.dart';
import 'package:smart_light/ui/widgets/qrscanner.dart';
import 'package:smart_light/ui/widgets/widgets.dart';

class HomeView extends StatefulWidget {
  static const String routeName = "/service/home";

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        direction: Axis.horizontal,
        children: _buildHomeServiceMenu(context),
      ),
    );
  }

  List<Padding> _buildHomeServiceMenu(BuildContext context) {
    final model = Provider.of<HomeModel>(context);

    final services = Service.getHomeService();
    return List.generate(
      4,
      (index) => Padding(
        padding:
            const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 8.0),
        child: GestureDetector(
          child: _buildContainer(index, context, services[index], model),
          onTap: () {
            if (model.localAddress == "") {
              if (index == 0 || index == 2) {
                final snackBar = SnackBar(
                    content: const Text('Trước tiên hãy kết nối Wifi !'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                return;
              }
            }

            model.changeIconSelected(index);

            switch (index) {
              case 0:
                break;
              case 1:
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => QRScanner(
                          onvalueChanged: (value) {
                            model.changeLocalAddress(value);
                            model.changeIconSelected(-1);
                          },
                        )));
                break;
              case 2:
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return HSVColorPicker(
                      pickerColor: model.currentColor,
                      onColorChanged: model.changeColor,
                    );
                  },
                ).then((val) {
                  setColor(model.currentColor);

                  Future.delayed(const Duration(milliseconds: 300), () {
                    model.changeIconSelected(-1);
                  });
                });
                break;
              default:
                Navigator.of(context)
                    .pushNamed(MusicScreen.routeName)
                    .whenComplete(() {
                  model.changeIconSelected(-1);
                });
            }
          },
        ),
      ),
    );
  }

  Container _buildContainer(
      int index, BuildContext context, Service service, model) {
    BorderRadius borderRaidus;
    Widget customWidget = Container();
    Widget subText = Container();

    switch (index) {
      case 0:
        borderRaidus = BorderRadius.only(topLeft: Radius.circular(15.0));
        customWidget = Text("${model.currentBrightness.toInt()}%",
            style: TextStyles.style.copyWith());
        break;
      case 1:
        // subText = Text("${model.localAddress}",
        //     style: TextStyles.style.copyWith(fontSize: 9));
        borderRaidus = BorderRadius.only(topRight: Radius.circular(15.0));
        customWidget = ClipOval(
          child: Container(
            height: 10.0,
            width: 10.0,
            color: model.localAddress == ""
                ? Colors.pinkAccent[700]
                : Colors.greenAccent[700],
          ),
        );
        break;
      case 2:
        borderRaidus = BorderRadius.only(bottomLeft: Radius.circular(15.0));
        customWidget = ClipOval(
          child: Container(
            height: 10.0,
            width: 10.0,
            color: model.currentColor,
          ),
        );
        break;
      default:
        borderRaidus = BorderRadius.only(bottomRight: Radius.circular(15.0));
    }

    return Container(
      padding: const EdgeInsets.all(10.0),
      height: MediaQuery.of(context).size.height / 6,
      width: MediaQuery.of(context).size.width / 2.8,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  service.icon,
                  color: Colors.blueGrey,
                ),
                customWidget,
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 45.0),
                  child: subText,
                ),
              ],
            ),
            Text(
              service.name,
              style: TextStyles.style.copyWith(
                fontSize: 16.0,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: borderRaidus,
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            offset: model.currentIconSelected == index
                ? Offset(-3, -3)
                : Offset(3, 3),
            color: Colors.black12,
            blurRadius: 3,
          ),
          BoxShadow(
            offset: model.currentIconSelected == index
                ? Offset(3, 3)
                : Offset(-3, -3),
            color: Colors.white,
            blurRadius: 3,
          ),
        ],
      ),
    );
  }
}
