import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeDisplay extends StatefulWidget {
  @override
  _TimeDisplayState createState() => _TimeDisplayState();
}

class _TimeDisplayState extends State<TimeDisplay> {
  static DateTime now = DateTime.now();
  String time = DateFormat.Hm().format(now);
  String dayAndMonth = DateFormat('EEE, MMM d').format(now);
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer t) {
        String currentTime = DateFormat.Hm().format(DateTime.now());
        if (currentTime != time) {
          setState(() {
            time = currentTime;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      time,
      style: TextStyle(
        color: Colors.white,
        fontSize: 50.0,
      ),
    );
  }
}
