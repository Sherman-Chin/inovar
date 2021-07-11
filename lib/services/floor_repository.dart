import 'package:firebase_core/firebase_core.dart';
import 'package:inovar/models/category.dart';
import 'package:inovar/models/floor.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class FloorRepository {
  final _loadedFloorData = StreamController<List<Floor>>();
  final _loadedCategoryData = StreamController<List<Category>>();
  final _floorCache = List<Floor>();
  final _categoryCache = List<Category>();

  Future _doneInitialize;


  FloorRepository._() {
    _doneInitialize = Firebase.initializeApp();
  }

  static final FloorRepository repo = FloorRepository._();

  factory FloorRepository() {
    return repo;
  }

  void dispose() {
    _loadedFloorData.close();
    _loadedCategoryData.close();
  }

  Future<void> getFloors() async {
    await _doneInitialize;
    if (FirebaseFirestore.instance != null) {
      FirebaseFirestore.instance
          .collection('floor')
          .snapshots()
          .listen((data) {
        _floorCache.clear();
        data.docs.forEach((floor) {
          final doc = floor.data();
          _floorCache.add(Floor.fromMap(doc));
        });
        _loadedFloorData.add(_floorCache);
      });
    }
  }

  Future<void> getCategories() async{
    await _doneInitialize;
    if (FirebaseFirestore.instance != null) {
      FirebaseFirestore.instance.collection('category').snapshots().listen((
          data) {
        _categoryCache.clear();
        data.docs.forEach((category) {
          final categoryName = category.id;
          _categoryCache.add(Category(name: categoryName));
        });
        _loadedCategoryData.add(_categoryCache);
      });
    }
  }

  Stream<List<Floor>> floors() => _loadedFloorData.stream;
  Stream<List<Category>> categories() => _loadedCategoryData.stream;
}
