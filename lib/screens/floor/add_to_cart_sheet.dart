
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovar/blocs/CartBloc.dart';
import 'package:inovar/models/floor.dart';
import 'package:inovar/services/cart_calculation_states.dart';
import 'package:inovar/services/cart_events.dart';
import 'package:inovar/services/database_events.dart';

/**
 * It seems that the CartPricing kept being recalled, even when the calculator screen is popped
 */

class AddToCart extends StatelessWidget {
  final Floor floor;

  AddToCart({@required this.floor});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CartPricing(floor: floor,),
            Container(
                child: VerticalDivider(
                  color: Theme.of(context).primaryColorLight,
                  thickness: 2.0,
                  indent: 10.0,
                  endIndent: 10.0,
                )
            ),
            CartEstimate(),
          ]),
    );
  }
}

class CartPricing extends StatelessWidget {
  final Floor floor;

  CartPricing({@required this.floor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PricingDetail(
            text: 'Amount per ...',
            value: 0,
            event: ChangeTempX(),
          ),
          PricingDetail(
            text: 'Price per Feet',
            value: 0,
            event: ChangeTempY(),
          ),
    ]);
  }
}

class PricingDetail extends StatefulWidget {
  final String text;
  final double value;
  final event;

  PricingDetail({this.text, this.value, this.event});

  @override
  _PricingDetailState createState() => _PricingDetailState();
}

class _PricingDetailState extends State<PricingDetail> {
  CartBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<CartBloc>(context);
    widget.event.setValue(widget.value);
    bloc.add(widget.event);
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Text(widget.text,
            style: Theme.of(context).textTheme.headline6),
        SizedBox(
          width: 100,
          height: 50,
          child: TextField(
            onChanged: (changedValue) {
              print(double.parse(changedValue));
              widget.event.setValue(double.parse(changedValue));
              bloc.add(widget.event);
              bloc.add(CalculatePrice());
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: widget.value == null ? '0' : widget.value.toString(),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}

class CartEstimate extends StatefulWidget {
  @override
  _CartEstimateState createState() => _CartEstimateState();
}

class _CartEstimateState extends State<CartEstimate> {
  CartBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<CartBloc>(context);
    bloc.add(CalculatePrice());
  }

  Widget buttonText(String text) {
    return FlatButton(
        onPressed: () { print('Confirm, Price: ' + text);},
        child: Text(text, style: Theme.of(context).textTheme.headline2,),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [FlatButton(
            child: BlocBuilder<CartBloc, CartCalculationState>(
              builder: (BuildContext context, CartCalculationState state) {
                if (state is PriceCalculating) {
                  return buttonText('\$' + '...');
                } else if (state is PriceCalculated) {
                  return buttonText('\$' + state.price.toString());
                } else if (state is InvalidTempX) {
                  return buttonText('Invalid ... given');
                } else {
                  return buttonText('Invalid pricing given');
                }
              },
            ),
        ),
        Container(
          margin: EdgeInsets.only(right: 20.0),
          child: Align(
            alignment: Alignment.centerRight,
              child: Text('Est.', style: Theme.of(context).textTheme.headline5,)
          ),
        )
      ]),
    );
  }
}
