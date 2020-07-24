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
              child: Container(
                height: 30.0,
                width: 200.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Done'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
