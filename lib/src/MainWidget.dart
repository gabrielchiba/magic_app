import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class MainWidget extends StatefulWidget {

  @override
  _MainWidgetState createState() => _MainWidgetState();

}


class _MainWidgetState extends State<MainWidget> {
  final Map cardBase = {
    "suits": ["club", "diamond", "heart", "spade"],
    "group": {
      0: ["1", "2", "3"],
      1: ["4", "5", "6"],
      2: ["7", "8", "9"],
      3: ["10", "j", "q", "k"],
      },
  };
  int _counter = 0;
  List chosenValue = [];
  @override
  Widget build(BuildContext context) {
    final children = new Scaffold(
      body: new Image.asset(
        "assets/images/mainScreen.jpeg",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
    return new GestureDetector(
      onTapDown: _onTapDown,
      child: children,
    );
  }

  _onTapDown(TapDownDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;

    int dx = (x / 190).floor();
    int dy = (y / 225).floor();
    print("x=$x y=$y dx=$dx dy=$dy");

    int position = dx + dy * 2;

    _detectValueOfCard(position);

    ++_counter;
}

  _detectValueOfCard(int position) {
    if (chosenValue.length < 3) {
      if (_counter == 0) chosenValue.add(cardBase["suits"][position]);
      else if(_counter == 1) chosenValue.add(cardBase["group"][position]);
      else _finalDetectionValueOfCard(position);
    }
    print(chosenValue);
  }

  _finalDetectionValueOfCard(int position) {
    chosenValue.add(position);
    _save();
  }

  _save() async{
    var tempDir = await getTemporaryDirectory();
    String savePath = tempDir.path + "/carta.jpg";
    print(savePath);

    String card = chosenValue[0] + chosenValue[1][chosenValue[2]];

    String urlPath = "https://github.com/gabrielchiba/magic_app/raw/master/assets/cards/$card.jpg";
    print(urlPath);

    await Dio().download(
        urlPath,
        savePath);

    final results = await ImageGallerySaver.saveFile(savePath);
    print(results);

  }
}
