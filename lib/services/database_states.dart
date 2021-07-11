import 'package:equatable/equatable.dart';
import 'package:inovar/models/category.dart';
import 'package:inovar/models/floor.dart';

abstract class DatabaseState extends Equatable{
  @override
  List<Object> get props => [];
}

class DatabaseLoadingState extends DatabaseState {}

class DatabaseFloorDataQueried extends DatabaseState {
  final List<Floor> floors;
  DatabaseFloorDataQueried(this.floors);
}

class DatabaseCategoryDataQueried extends DatabaseState {
  final List<Category> categories;
  DatabaseCategoryDataQueried(this.categories);
}

class DatabaseError extends DatabaseState {
  final Error error;
  DatabaseError(this.error);
}