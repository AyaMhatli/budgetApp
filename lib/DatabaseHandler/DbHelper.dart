import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:login_with_signup/Model/UserModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import 'package:sqflite/sqflite.dart' as sql;

import '../Model/Categorie.dart';


class DbHelper {
  static Database _db;

  static const String DB_Name = 'test.db';
  static const String Table_User = 'user';
  static const int Version = 1;

  static const String C_UserID = 'user_id';
  static const String C_UserName = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_User ("
        " $C_UserID TEXT, "
        " $C_UserName TEXT, "
        " $C_Email TEXT,"
        " $C_Password TEXT, "
        " PRIMARY KEY ($C_UserID)"
        ")");
  }

  Future<int> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_User, user.toMap());
    return res;
  }

  Future<UserModel> getLoginUser(String userId, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_UserID = '$userId' AND "
        "$C_Password = '$password'");

    if (res.length > 0) {
      return UserModel.fromMap(res.first);
    }

    return null;
  }

  Future<int> updateUser(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.update(Table_User, user.toMap(),
        where: '$C_UserID = ?', whereArgs: [user.user_id]);
    return res;
  }

  Future<int> deleteUser(String user_id) async {
    var dbClient = await db;
    var res = await dbClient
        .delete(Table_User, where: '$C_UserID = ?', whereArgs: [user_id]);
    return res;
  }

  static Future<void> createTable(sql.Database database) async {

        await database.execute(""" CREATE TABLE  categorie (
          id_cat INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          name TEXT,
          description Text,
          Type TEXT,
        )""");

  }

  static Future<sql.Database> bd () async {

      return sql.openDatabase(DB_Name, 
      version: 1,onCreate: (sql.Database database , int version) async
      {
        await createTable(database);
      },
      )  ;
  }
  static Future<int> createCat(String name, String type, String descrption) async {
    final db = await DbHelper.bd();

    final data = {'name': name, 'description': descrption, 'type': type};
    final id = await db.insert('categorie', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
   static Future<List<Map<String, dynamic>>> getCat() async {
    final db = await DbHelper.bd();
    return db.query('categorie', orderBy: "id");
  }
   Future<int> saveCat(Categorie categorie) async {
    var dbClient = await db;
    var res = await dbClient.insert('categorie', categorie.toMap());
    return res;
  } 
   static Future<int> updateCat(
      int id, String name, String descrption,String type) async {
    final db = await DbHelper.bd();

    final data = {
      'title': name,
      'description': descrption,
      'type':type,
      
    };

    final result =
    await db.update('categorie', data, where: "id = ?", whereArgs: [id]);
    return result;
  }
    static Future<void> deleteCat(int id) async {
    final db = await DbHelper.bd();
    try {
 
      await db.delete ('categorie', where: 'cat-id = ?', whereArgs: ['cat_id']);
  }
    catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

}
