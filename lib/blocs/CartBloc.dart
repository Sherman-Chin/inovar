import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovar/models/floor.dart';
import 'package:inovar/services/cart_calculation_states.dart';
import 'package:inovar/services/cart_events.dart';

class CartBloc extends Bloc<CartEvent, CartCalculationState> {
  final Floor floor;
  double tempX;
  double tempY;

  CartBloc({@required this.floor, tempX, tempY}) : super(CartInitState());

  @override
  Stream<CartCalculationState> mapEventToState(CartEvent event) async* {
    if (event is ChangeTempX) {
      tempX = event.tempX;
    }

    if (event is ChangeTempY) {
      tempY = event.tempY;
    }

    if (event is CalculatePrice) {
      if (tempX == null) {
        yield InvalidTempX(tempX);
      }
      else if (tempY == null) {
        yield InvalidTempY(tempY);
      }
      else {
        yield PriceCalculating();
        double price = tempX * tempY;
        // print("tempX: " + tempX.toString());
        // print("tempY: " + tempY.toString());
        yield PriceCalculated(price: price);
      }
    }

  }
}
