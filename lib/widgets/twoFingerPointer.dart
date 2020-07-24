import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class TwoFingerPointerWidget extends StatelessWidget {
  final Widget child;
  final OnUpdate onUpdate;

  TwoFingerPointerWidget({this.child, this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        CustomVerticalMultiDragGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<
                CustomVerticalMultiDragGestureRecognizer>(
          () => CustomVerticalMultiDragGestureRecognizer(),
          (CustomVerticalMultiDragGestureRecognizer instance) {
            instance.onStart = (Offset position) {
              return CustomDrag(events: instance.events, onUpdate: onUpdate);
            };
          },
        ),
      },
      child: child,
    );
  }
}

typedef OnUpdate(DragUpdateDetails details);

class CustomDrag extends Drag {
  final List<PointerDownEvent> events;

  final OnUpdate onUpdate;

  CustomDrag({this.events, this.onUpdate});

  @override
  void update(DragUpdateDetails details) {
    super.update(details);
    final delta = details.delta;
    if (delta.dy.abs() > 0 && events.length == 2) {
      onUpdate?.call(DragUpdateDetails(
        sourceTimeStamp: details.sourceTimeStamp,
        delta: Offset(0, delta.dy),
        primaryDelta: details.primaryDelta,
        globalPosition: details.globalPosition,
        localPosition: details.localPosition,
      ));
    }
  }

  @override
  void end(DragEndDetails details) {
    super.end(details);
  }
}

class CustomVerticalMultiDragGestureRecognizer
    extends MultiDragGestureRecognizer<_CustomVerticalPointerState> {
  final List<PointerDownEvent> events = [];

  @override
  createNewPointerState(PointerDownEvent event) {
    events.add(event);
    return _CustomVerticalPointerState(event.position, onDisposeState: () {
      events.remove(event);
    });
  }

  @override
  String get debugDescription => 'custom vertical multidrag';
}

typedef OnDisposeState();

class _CustomVerticalPointerState extends MultiDragPointerState {
  final OnDisposeState onDisposeState;

  _CustomVerticalPointerState(Offset initialPosition, {this.onDisposeState})
      : super(initialPosition);

  @override
  void checkForResolutionAfterMove() {
    if (pendingDelta.dy.abs() > kTouchSlop) {
      resolve(GestureDisposition.accepted);
    }
  }

  @override
  void accepted(GestureMultiDragStartCallback starter) {
    starter(initialPosition);
  }

  @override
  void dispose() {
    onDisposeState?.call();
    super.dispose();
  }
}
