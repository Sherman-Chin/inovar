import 'package:firebase_core/firebase_core.dart';
import 'package:inovar/models/floor.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class FloorRepository {
  final _loadedData = StreamController<List<Floor>>();
  final _cache = List<Floor>();

  FloorRepository() {
    getFloors();
  }

  void dispose() {
    _loadedData.close();
  }

  void getFloors() async {
    await Firebase.initializeApp();
    if (FirebaseFirestore.instance != null) {

      FirebaseFirestore.instance
          .collection('floor')
          .snapshots()
          .listen((data) {
        _cache.clear();
        data.docs.forEach((floor) {
          final doc = floor.data();
          _cache.add(Floor.fromMap(doc));
        });
        _loadedData.add(_cache);
      });
    }
  }

  Stream<List<Floor>> floors() => _loadedData.stream;
}
