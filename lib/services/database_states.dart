import 'package:equatable/equatable.dart';
import 'package:inovar/models/floor.dart';

abstract class DatabaseState extends Equatable{
  @override
  List<Object> get props => [];
}

class DatabaseLoadingState extends DatabaseState {}

class DatabaseQueried extends DatabaseState {
  final List<Floor> floors;
  DatabaseQueried(this.floors);
}

class DatabaseError extends DatabaseState {
  final Error error;
  DatabaseError(this.error);
}