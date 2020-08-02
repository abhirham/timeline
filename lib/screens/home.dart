import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timeline/data/settings.dart';
import 'package:timeline/screens/settings_screen.dart';
import 'package:timeline/widgets/inputScreen.dart';
import 'package:timeline/widgets/stretchedImage.dart';
import 'package:timeline/widgets/twoFingerPointer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String id = "homeScreen";

  @override
  Widget build(BuildContext context) {
    if (context.watch<Settings>().showInputScreen) {
      return InputScreen();
    }

    return TwoFingerPointerWidget(
      onUpdate: (DragUpdateDetails details) {
        if (details.delta.direction > 0) {
          SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
          Navigator.pushNamed(context, SettingsScreen.id).then((value) {
            SystemChrome.setEnabledSystemUIOverlays([]);
            context.read<Settings>().saveData();
          });
        } else if (details.delta.direction < 0) {
          SystemNavigator.pop();
        }
      },
      child: GestureDetector(
        onTap: () {
          context.read<Settings>().startTimeTravel();
        },
        onLongPress: () {
          if (context.read<Settings>().useInputScreen) {
            context.read<Settings>().showInputScreen = true;
          } else {
            context.read<Settings>().setTimeToAdd = 0;
            context.read<Settings>().prepMagic();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomStack(
            child: Positioned(
              top: context.watch<Settings>().y,
              left: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  Text(
                    context.watch<Settings>().time,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60.0,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    context.watch<Settings>().dateAndMonth,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomStack extends StatelessWidget {
  final Widget child;

  CustomStack({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (_, settings, __) => Stack(
        children: [
          StretchedImage(settings.screenShotPath),
          ClipRect(
            clipper: MyClipper(settings),
            child: StretchedImage(settings.clockDownScreenShotPath),
          ),
          child,
          CloseToMinuteIndicator()
        ],
      ),
    );
  }
}

class CloseToMinuteIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: context.watch<Settings>().closeToMinute
          ? Icon(
              Icons.radio_button_unchecked,
              color: Colors.white,
            )
          : null,
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  final Settings _settings;

  MyClipper(this._settings);

  @override
  getClip(Size size) {
    Rect rect = Rect.fromLTWH(
        _settings.x, _settings.y, _settings.width, _settings.height);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
