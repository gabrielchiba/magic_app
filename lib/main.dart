import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magic_app/src/GalleryWidget.dart';
import 'package:magic_app/src/MainWidget.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final status = [
    Permission.storage,
  ].request();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'Flutter Magic',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = PageView(
      controller: _pageController,
      children: [
        MainWidget(),
        GalleryWidget(),
      ],
    );
    return pages;
  }
}
