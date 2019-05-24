import 'package:real_final_mobile/models/Users.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';


final String tableUsers = 'users';
final String colId = "id";
final String colUserId = 'userid';
final String colName = "name";
final String colAge = "age";
final String colPass = "password";
final String colQuote = "quote";


class DatabaseManage {
  static final DatabaseManage _instance = new DatabaseManage.internal();
  factory DatabaseManage() => _instance;
  static Database _db;
  DatabaseManage.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'users.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      create table $tableUsers (
        $colId integer primary key autoincrement,
        $colUserId text not null unique,
        $colName text not null,
        $colAge text not null,
        $colPass text not null,
        $colQuote text
      )
      ''');
  }

  //insert
  Future<int> saveNewUsers(Users users) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableUsers, users.toMap());
    return result;
  }

  //read
  Future<List> getAllUsers() async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableUsers,
        columns: [
          colId,
          colUserId,
          colName,
          colAge,
          colPass,
        ],
        where: '$colId > ?',
        whereArgs: [0]);
    return result;
  }

  //update
  Future<int> updateUsers(Users users) async {
    var dbClient = await db;
    print("update");
    return await dbClient.update(tableUsers, users.toMap(),
        where: "$colId = ?", whereArgs: [users.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

}