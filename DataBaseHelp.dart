import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'User.dart';

class DataBaseHelper {
  Future<Database> conectaDB() async {
    return openDatabase(join(await getDatabasesPath(), 'users.db'), version: 1,
        onCreate: (Database db, version) async {
      db.execute("""
              CREATE TABLE users(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                email TEXT NOT NULL)""");
    });
  }

  Future insertUser(User user) async {
    final Database db = await conectaDB();
    await db.insert('users', user.toMap());
  }

  Future updatetUser(User user) async {
    final Database db = await conectaDB();
    await db
        .update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future deleteUser(int id) async {
    final Database db = await conectaDB();
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<User>> consultaUsers() async {
    final Database db = await conectaDB();
    final List<Map<String, Object?>> queryResult = await db.query('users');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }
}
