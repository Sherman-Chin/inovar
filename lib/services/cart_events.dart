import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CalculatePrice extends CartEvent {}

class ChangeTempX extends CartEvent {
  double tempX;

  ChangeTempX({tempX});

  void setValue(double value) {
    tempX = value;
  }
}

class ChangeTempY extends CartEvent {
  double tempY;

  ChangeTempY({tempY});

  void setValue(double value) {
    tempY = value;
  }
}