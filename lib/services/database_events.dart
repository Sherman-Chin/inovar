import 'package:inovar/models/category.dart';
import 'package:inovar/models/floor.dart';

abstract class DatabaseEvents {}

class HasFloorDataEvent extends DatabaseEvents {
  final List<Floor> floors;
  HasFloorDataEvent(this.floors);
}

class RequestFloorData extends DatabaseEvents {
  final List<String> categories;
  RequestFloorData({this.categories});
}

class HasCategoryDataEvent extends DatabaseEvents {
  final List<Category> categories;
  HasCategoryDataEvent(this.categories);
}

class RequestCategoryData extends DatabaseEvents {}