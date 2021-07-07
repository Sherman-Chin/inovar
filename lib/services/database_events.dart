import 'package:inovar/models/floor.dart';

abstract class DatabaseEvents {}

class HasDataEvent extends DatabaseEvents {
  final List<Floor> floors;
  HasDataEvent(this.floors);
}

