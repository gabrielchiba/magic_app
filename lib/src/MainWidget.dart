import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class MainWidget extends StatelessWidget {
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
    print(position);

    _save(position);
  }

  _save(int position) async{
    var tempDir = await getTemporaryDirectory();
    String savePath = tempDir.path + "/carta-$position.jpg";
    print(savePath);

    String urlPath = "";

    await Dio().download(
        urlPath,
        savePath);

    final results = await ImageGallerySaver.saveFile(savePath);
    print(results);

  }


}
