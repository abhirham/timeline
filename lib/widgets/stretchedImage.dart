import 'dart:io';
import 'package:flutter/material.dart';

class StretchedImage extends StatelessWidget {
  final String path;

  StretchedImage(this.path);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: FileImage(
          File(path ?? ""),
        ),
        fit: BoxFit.fill,
      )),
    );
  }
}
