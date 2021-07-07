import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovar/services/database_events.dart';
import 'package:inovar/services/floor_database.dart';
import 'package:inovar/services/database_states.dart';

class FloorBloc extends Bloc<DatabaseEvents, DatabaseState> {
  final FloorRepository floorDatabase;

  FloorBloc({this.floorDatabase}) : super(DatabaseLoadingState()) {
    floorDatabase.floors().listen((data) => add(HasDataEvent(data)));
  }

  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvents event) async* {
    if (event is HasDataEvent) {
      event.floors.sort((a,b) => a.name.compareTo(b.name));
      yield DatabaseQueried(event.floors);
    }
  }
}