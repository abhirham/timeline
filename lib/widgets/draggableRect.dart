import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeline/data/settings.dart';

enum vertical { top, bottom }
enum horizontal { left, right }

class DraggableRect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (_, settings, __) => Positioned(
        top: settings.y - 10,
        left: settings.x - 10,
        child: SizedBox(
          width: settings.width + 20,
          height: settings.height + 20,
          child: Stack(
            children: [
              Positioned(
                top: 10.0,
                left: 10.0,
                child: GestureDetector(
                  onPanUpdate: (tapInfo) {
                    settings.setX = settings.x + tapInfo.delta.dx;
                    settings.setY = settings.y + tapInfo.delta.dy;
                  },
                  child: Container(
                    width: settings.width,
                    height: settings.height,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.0),
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: CustomGestureDetector(vertical.top, horizontal.right),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: CustomGestureDetector(vertical.top, horizontal.left),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: CustomGestureDetector(vertical.bottom, horizontal.left),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CustomGestureDetector(vertical.bottom, horizontal.right),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomGestureDetector extends StatelessWidget {
  final vertical vert;
  final horizontal hor;

  CustomGestureDetector(this.vert, this.hor);

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (_, settings, __) => GestureDetector(
        onPanUpdate: (ti) {
          double dx = ti.delta.dx;
          double dy = ti.delta.dy;

          double height = vert == vertical.top
              ? settings.height - dy
              : settings.height + dy;

          double width = hor == horizontal.right
              ? settings.width + dx
              : settings.width - dx;

          if (height > 50.0) {
            settings.setHeight = height;
            if (vert == vertical.top) settings.setY = settings.y + dy;
          }

          if (width > 50.0) {
            settings.setWidth = width;
            if (hor == horizontal.left) settings.setX = settings.x + dx;
          }
        },
        child: Icon(
          Icons.lens,
          color: Colors.white,
        ),
      ),
    );
  }
}
