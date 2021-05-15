import 'dart:io';
import 'package:login_stateful/hackernews/models/ItemModels.dart';
import 'package:login_stateful/hackernews/resources/repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class NewsDbProvider implements Source, Cache {
  Database db;

  NewsDbProvider() {
    init();
  }

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'items13.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      return newDb.execute(""" CREATE TABLE Item1
        (
          id INTEGER PRIMARY KEY,
          deleted INTEGER,
          type TEXT,
          by TEXT,
          time INTEGER,
          text TEXT,
          dead INTEGER,
          parent INTEGER,
          poll INTEGER,
          kids BLOB,
          url TEXT,
          score INTEGER,
          title TEXT,
          descendants INTEGER
        ) 
        """);
    });
  }

  Future<ItemModel> fetchTopItems(int id) async {
    final maps = await db.query(
      'Item1',
      columns: null,
      where: 'id=?',
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert(
      'Item1',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<int> clear() {
    return db.delete('Item1');
  }

  Future<List<int>> fetchTopIds() {
    return null;
  }
}

final newsDbProvider = NewsDbProvider();
