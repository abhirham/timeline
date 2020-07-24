import 'package:flutter/material.dart';

typedef OnChanged(bool val);

class CustomSwitchListTile extends StatelessWidget {
  final String title;
  final OnChanged onChanged;
  final bool value;

  CustomSwitchListTile(
      {@required this.title, @required this.value, @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SwitchListTile(
        title: Text(title),
        onChanged: onChanged,
        value: value,
      ),
    );
  }
}
