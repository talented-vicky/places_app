import 'package:path/path.dart';
import 'package:places_app/models/place.dart';

import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';

class PlacesDB {
  static Future<Database> createDB() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'places.db'),
      onCreate: (db, version) => db.execute(
          'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT, location NULL)'),
      version: 1,
    );
  }

  static Future<void> deleteDB() async {
    final dbPath = await getDatabasesPath();
    deleteDatabase(
      join(dbPath, 'places.db'),
    );
  }

  static Future<void> insertTable(
      // String tableName,
      // Map<String, Object> data) async {
      String tableName,
      Place place) async {
    final db = await PlacesDB.createDB();
    await db.insert(
      tableName,
      place.toMap(),
      // data, // tables's object to be inserted
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String tableName) async {
    final db = await PlacesDB.createDB();
    return await db.query(tableName);
  }
}
