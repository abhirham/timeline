import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeline/data/settings.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  Color color = Colors.white;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    if (context.read<Settings>().hideInputScreen) {
      _timer = Timer(Duration(seconds: 2), () {
        setState(() {
          color = Colors.black;
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          CustomRow([1, 2, 3], color),
          CustomRow([4, 5, 6], color),
          CustomRow([7, 8, 9], color),
          CustomRow([null, 0, null], color),
        ],
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  final List<int> numbers;
  final Color color;

  CustomRow(this.numbers, this.color);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: numbers.map((num) {
          if (num == null) {
            return Spacer();
          }

          return Expanded(
            child: FlatButton(
              textColor: color,
              highlightColor: Colors.black,
              splashColor: Colors.black,
              onPressed: () {
                context.read<Settings>().setTimeToAdd = num;
                context.read<Settings>().showInputScreen = false;
                context.read<Settings>().prepMagic();
              },
              child: Text(
                '$num',
                style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w300),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
