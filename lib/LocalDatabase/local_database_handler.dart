import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:test_app/Util/tools.dart';

class LocalDatabaseHandler {
  /*===================>
  Variables Declaring
  <===================*/
  final String dbName = 'CMS_UK.db';
  final int dbVersion = 1;
  Database? _database;
  String dbPath = '';

  /*===================>
  Checking Database Available or Not
  <===================*/
  Future<Database?> get getDatabase async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  /*===================>
  Initializing Database and Opening Database
  <===================*/
  Future<Database> initDatabase() async {
    //Directory? documentsDirectory = await getExternalStorageDirectory();
    try {
    //  dbPath = join(documentsDirectory!.path, dbName);
      var database = await openDatabase(dbName, version: dbVersion);
      // print("check path");
      // print(database.path);
      return database;
    } catch (e) {
      rethrow;
    }
  }

  /*===================>
  Checking Database is Exist or Not
  <===================*/
  Future<bool> doesTableExist({required String tableName}) async {
    try {
      Database? db = await getDatabase;
      List<Map<String, Object?>> tables =
          await db!.query('sqlite_master', columns: ['name']);
      final data = tables
          .any((Map<String, dynamic> table) => table['name'] == tableName);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  /*===================>
    Creating Database Table
    <===================*/
  Future<void> createTable({required String sqlInject}) async {
    Database? db = await getDatabase;
    try {
      await db!.execute(sqlInject);
    } catch (e) {
      rethrow;
    }
  }

  //for display
  Future<List<Map<String, dynamic>>> getDPDAllClientList() async {
    Database? db = await getDatabase;
    final List<Map<String, dynamic>> maps = await db!.query('DPD_ORG_ALL_CLIENT_LIST');

    return maps;
  }

  Future<int> insertList(String title) async {
    Database? db = await getDatabase;
    try {
      int id = await db!.insert(
        'LIST',
        {'title': title},
        conflictAlgorithm: ConflictAlgorithm.replace, // To handle duplicate entries
      );
      return id; // Return the ID of the inserted row
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchListData() async {
    Database? db = await getDatabase;
    try {

      final List<Map<String, dynamic>> result = await db!.query('LIST');
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> deleteList(int id) async {
    Database? db = await getDatabase;
    try {
      int count = await db!.delete(
        'LIST',
        where: 'id = ?',
        whereArgs: [id],
      );
      if(count>0){
        showToastInfo("DELETED");
      }
      return count;
    } catch (e) {
      showToastInfo("Error Delete");
      rethrow;
    }
  }



}
