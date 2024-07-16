import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/constants.dart';

class DatabaseHelper {
  DatabaseHelper._instance();

  static final DatabaseHelper db = DatabaseHelper._instance();
  late Database _database;

  Future<Database> get database async {
    _database = await _initDB();

    return _database;
  }

  Future<Database> _initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String databasePath = "${directory.path}/$databaseName";

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(createLastViewTable);
  }

  Future close() async {
    var dbClient = await database;
    return dbClient.close();
  }
}
