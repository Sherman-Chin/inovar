import 'package:flutter/cupertino.dart';
import 'package:inovar/models/floor.dart';

class InheritedFloor extends InheritedWidget {
  final Floor floor;

  InheritedFloor({this.floor, Widget child}): super(child: child);

  @override
  bool updateShouldNotify(InheritedFloor oldWidget) => floor != oldWidget.floor;

  static InheritedFloor of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedFloor>();
  }
}