import 'package:flutter/material.dart';
import 'package:timeline/data/settings.dart';
import 'package:timeline/widgets/draggableRect.dart';
import 'package:timeline/widgets/stretchedImage.dart';
import 'package:provider/provider.dart';

class DraggableScreen extends StatelessWidget {
  static const String id = "draggableScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StretchedImage(context.watch<Settings>().screenShotPath),
          DraggableRect(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: FlatButton(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Done'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
