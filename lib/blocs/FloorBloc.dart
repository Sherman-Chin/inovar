import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovar/services/events.dart';
import 'package:inovar/services/floor_database.dart';
import 'package:inovar/services/states.dart';

class FloorBloc extends Bloc<DatabaseEvents, DatabaseState> {
  final FloorDatabase floorDatabase;

  FloorBloc({this.floorDatabase}) : super(DatabaseInitState());

  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvents event) async* {
    switch (event) {
      case DatabaseEvents.GetFloorSamples:
        yield DatabaseLoadingState();
        var floors = await floorDatabase.getFloorWithId(0);
        yield DatabaseQueried(floors);
        break;
    }
  }

}