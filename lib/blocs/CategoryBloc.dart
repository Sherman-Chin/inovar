import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovar/models/category.dart';
import 'package:inovar/services/database_events.dart';
import 'package:inovar/services/floor_repository.dart';
import 'package:inovar/services/database_states.dart';

class CategoryBloc extends Bloc<DatabaseEvents, DatabaseState> {
  final FloorRepository floorDatabase;

  CategoryBloc({this.floorDatabase}) : super(DatabaseLoadingState()) {
    floorDatabase.categories().listen((data) => add(HasCategoryDataEvent(data)));
  }

  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvents event) async* {
    if (event is HasCategoryDataEvent) {
      List<Category> categories = event.categories;
      categories.sort((a,b) => a.name.compareTo(b.name));
      yield DatabaseCategoryDataQueried(categories);
    }
    else if (event is RequestCategoryData) {
      yield DatabaseLoadingState();
      floorDatabase.getCategories();
    }
  }
  
}