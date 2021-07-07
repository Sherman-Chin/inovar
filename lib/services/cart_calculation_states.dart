import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class CartCalculationState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartInitState extends CartCalculationState {}

class PriceCalculating extends CartCalculationState {}

class PriceCalculated extends CartCalculationState {
  final double price;

  PriceCalculated({@required this.price});
}

class InvalidTempX extends CartCalculationState {
  double tempX;

  InvalidTempX(tempX);
}

class InvalidTempY extends CartCalculationState {
  double tempY;

  InvalidTempY(tempY);
}
