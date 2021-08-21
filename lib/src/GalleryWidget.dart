import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';

class GalleryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final children = new Scaffold(
      body: new Image.asset(
        "assets/images/galleryScreen.jpeg",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
    return new GestureDetector(
      onTap: _openGallery,
      child: children,
    );
  }

  _openGallery() {
    final intent = AndroidIntent(
      action: 'action_view',
      type: 'image/*',
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    intent.launch();
  }

}
