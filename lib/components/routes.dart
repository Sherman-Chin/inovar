import 'package:inovar/main.dart';
import 'package:flutter/material.dart';

class Routes {
  List<ScreenRoute> _routes = <ScreenRoute>[];
  Routes() {
    _routes.add(HomeRoute());
    _routes.add(FloorsRoute());
  }

  List<ScreenRoute> get routes => _routes;
}

abstract class ScreenRoute {
  Icon logo(Color color);
  String title();
  String toString();
}

class HomeRoute extends ScreenRoute {
  @override
  Icon logo(Color color) {
    return Icon(
      Icons.home,
      color: color,
    );
  }

  @override
  String toString() {
    return "/";
  }

  @override
  String title() {
    return "home";
  }
}

class FloorsRoute extends ScreenRoute {
  @override
  Icon logo(Color color) {
    return Icon(
      Icons.photo,
      color: color,
    );
  }

  @override
  String title() {
    return "Floors";
  }

  @override
  String toString() {
    return "/floors";
  }
}
