import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovar/services/database_events.dart';
import 'package:inovar/services/floor_repository.dart';
import 'package:inovar/services/database_states.dart';

class FloorBloc extends Bloc<DatabaseEvents, DatabaseState> {
  final FloorRepository floorDatabase;

  FloorBloc({this.floorDatabase}) : super(DatabaseLoadingState()) {
    floorDatabase.floors().listen((data) => add(HasFloorDataEvent(data)));
  }

  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvents event) async* {
    if (event is HasFloorDataEvent) {
      event.floors.sort((a,b) => a.name.compareTo(b.name));
      yield DatabaseFloorDataQueried(event.floors);
    }
    else if (event is RequestFloorData) {
      yield(DatabaseLoadingState());
      // List<String> categories = event.categories;
      floorDatabase.getFloors();
    }
  }
}