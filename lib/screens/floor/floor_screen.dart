import 'package:flutter/material.dart';
import 'package:inovar/blocs/CategoryBloc.dart';
import 'package:inovar/blocs/FloorBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovar/models/floor.dart';
import 'package:inovar/screens/floor/floor_card.dart';
import 'package:inovar/screens/floor/inherited_floor_provider.dart';
import 'package:inovar/services/database_events.dart';
import 'package:inovar/services/database_states.dart';
import 'package:inovar/components/root_scaffold.dart';
import 'package:inovar/screens/floor/search_section.dart';

class FloorScreen extends StatefulWidget {
  @override
  _FloorScreenState createState() => _FloorScreenState();
}

class _FloorScreenState extends State<FloorScreen> {
  Bloc floorBloc;

  @override
  void initState() {
    super.initState();
    floorBloc = BlocProvider.of<FloorBloc>(context);
    floorBloc.add(RequestFloorData(categories: null));
  }

  @override
  void dispose() {
    floorBloc.close();
    super.dispose();
  }

  Widget _getCards(List<Floor> floors) {
    int numFloor = floors.length;
    double diff = 1.0 / numFloor;
    double begin = -diff;

    return Expanded(
      child: ListView(children: [
        Container(
          alignment: Alignment.center,
          child: Wrap(
            children: floors.map((floor) {
              begin += diff;
              return InheritedFloor(
                child: FloorCard(
                  begin: begin,
                  end: begin + diff,
                ),
                floor: floor,
              );
            }).toList(),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget title = Text('Samples');

    final Widget content = Center(
      child: Row(children: [
        SearchSection(),
        BlocBuilder<FloorBloc, DatabaseState>(
            builder: (BuildContext context, DatabaseState state) {
          if (state is DatabaseFloorDataQueried) {
            return _getCards(state.floors);
          } else {
            return Text('Loading');
          }
        }),
      ]),
    );

    return RootScaffold(title, content);
  }
}