import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper getDBinstance = DBHelper._();
  Future<Database>? myDB;
  //      //         //TAble Schema
  static final String tableName = "notes_of_user";
  static final String col_1 = "sno";
  static final String col_2 = "title";
  static final String col_3 = "content";
  static final String col_4 = "date";

  //      //         //
  Future<Database> openDB() async {
    Directory appDirec = await getApplicationDocumentsDirectory();
    String dbPath = join(appDirec.path, "UserDB");
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "create table $tableName ($col_1 integer primary key autoincrement, $col_2 text, $col_3 text, $col_4 Date)",
        );
      },
    );
  }

  //      //         //
  Future<Database> getDB() {
    myDB = myDB ?? openDB();
    return myDB!;
  }
}
