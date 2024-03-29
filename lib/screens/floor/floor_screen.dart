import 'package:flutter/material.dart';
import 'package:inovar/blocs/FloorBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovar/models/floor.dart';
import 'package:inovar/screens/floor/floor_card.dart';
import 'package:inovar/services/events.dart';
import 'package:inovar/services/states.dart';
import 'package:panorama/panorama.dart';
import 'package:inovar/components/root_scaffold.dart';

class FloorScreen extends StatefulWidget {
  @override
  _FloorScreenState createState() => _FloorScreenState();
}

class _FloorScreenState extends State<FloorScreen> {
  FloorBloc floorBloc;

  @override
  void initState() {
    super.initState();
    floorBloc = BlocProvider.of<FloorBloc>(context);
  }

  Widget _getCards(List<Floor> floors) {
    return Wrap(
      children: floors.map((floor) {
        return FloorCard(
          floorName: floor.name,
          floorDescription: floor.description,
          imageName: floor.image,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget title = Text('Samples');
    // final Widget content = Panorama(
    //   child: Image.asset('assets/images/pan.jpg'),
    //   sensitivity: 1.5,
    // );

    final Widget content = Center(
      child: ListView(
        children: [
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.message),
                onPressed: () => floorBloc.add(DatabaseEvents.GetFloorSamples),
              ),
              BlocBuilder<FloorBloc, DatabaseState>(
                  builder: (BuildContext context, DatabaseState state) {
                if (state is DatabaseQueried) {
                  return _getCards(state.floors);
                } else {
                  return Text('Loading');
                }
              })
            ],
          ),
        ],
      ),
    );

    return RootScaffold(title, content);
  }
}
