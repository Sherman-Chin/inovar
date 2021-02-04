import 'package:inovar/models/floor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';

class FloorDatabase {
  static FloorDatabase floorDb;

  Completer<Database> _completer;

  FloorDatabase._internal();

  static FloorDatabase getInstance() {
    if (floorDb == null) {
      floorDb = FloorDatabase._internal();
    }
    return floorDb;
  }

  Future<Database> _database() {
    if (_completer == null) {
      _completer = Completer();
      _openDatabase();
    }
    return _completer.future;
  }

  Future _openDatabase() async {
    Directory databasePath = await getApplicationDocumentsDirectory();
    String dbPath = join(databasePath.path, 'floor_detail.db');
    Database db = await openDatabase(dbPath, version: 1, onCreate: _initDatabase);
    _completer.complete(db);
  }

  void _initDatabase(Database db, int version) async {
    await db.transaction((txn) async {
      await db.execute('DROP TABLE IF EXISTS FloorDetail');
      await db.execute('DROP TABLE IF EXISTS FloorTags');
      
      await db.execute('CREATE TABLE FloorDetail'
          '(id INTEGER PRIMARY KEY,'
          'name TEXT,'
          'description TEXT)'
      );

      await db.execute('CREATE TABLE FloorTags'
          '(tag TEXT PRIMARY KEY,'
          'floor_id INTEGER)'
      );
    });
  }

  Future<List<Floor>> getFloorWithId (int id) async {
    // Database db = await _database();
    //And then perform stuff on the db
    var result = await Future.delayed(const Duration(seconds: 1), () => List.of([Floor(
      id: 0,
      name: 'sample',
      description: 'testing',
      image: 'assets/images/' + 'wooden-floor.jpg',
      categories: ['cat1', 'cat2'],
      tags: ['tag1', 'tag2']
    ),
      Floor(
          id: 0,
          name: 'sample',
          description: 'testing',
          image: 'assets/images/' + 'wooden-floor.jpg',
          categories: ['cat1', 'cat2'],
          tags: ['tag1', 'tag2']
      ),
      Floor(
          id: 0,
          name: 'sample',
          description: 'testing',
          image: 'assets/images/' + 'wooden-floor.jpg',
          categories: ['cat1', 'cat2'],
          tags: ['tag1', 'tag2']
      ),
      Floor(
          id: 0,
          name: 'sample',
          description: 'testing',
          image: 'assets/images/' + 'wooden-floor.jpg',
          categories: ['cat1', 'cat2'],
          tags: ['tag1', 'tag2']
      ),
      Floor(
          id: 0,
          name: 'sample',
          description: 'testing',
          image: 'assets/images/' + 'wooden-floor.jpg',
          categories: ['cat1', 'cat2'],
          tags: ['tag1', 'tag2']
      ),
      Floor(
          id: 0,
          name: 'sample',
          description: 'testing',
          image: 'assets/images/' + 'wooden-floor.jpg',
          categories: ['cat1', 'cat2'],
          tags: ['tag1', 'tag2']
      ),
      Floor(
          id: 0,
          name: 'sample',
          description: 'testing',
          image: 'assets/images/' + 'wooden-floor.jpg',
          categories: ['cat1', 'cat2'],
          tags: ['tag1', 'tag2']
      ),
      Floor(
          id: 0,
          name: 'sample',
          description: 'testing',
          image: 'assets/images/' + 'wooden-floor.jpg',
          categories: ['cat1', 'cat2'],
          tags: ['tag1', 'tag2']
      ),
      Floor(
          id: 0,
          name: 'sample',
          description: 'testing',
          image: 'assets/images/' + 'wooden-floor.jpg',
          categories: ['cat1', 'cat2'],
          tags: ['tag1', 'tag2']
      ),

      Floor(
          id: 0,
          name: 'sample',
          description: 'testing',
          image: 'assets/images/' + 'wooden-floor.jpg',
          categories: ['cat1', 'cat2'],
          tags: ['tag1', 'tag2']
      ),
    ]));
    return result;
  }
}