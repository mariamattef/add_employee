import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class EmployeeDb {
  Database? db;
  EmployeeDb() {
    _init();
  }
  void createTables() async {
    try {
      await db!.execute('''
        create table 'employee' (
        id integer primary key autoincrement,
        name String,
        email String,
        password String,
        phone String
        )
''');
    } catch (e) {
      print('Error $e');
    }
  }

  void _init() async {
    try {
      if (kIsWeb) {
        var factory = databaseFactoryFfiWeb;
        db = await factory.openDatabase('emp.db');
      } else {
        db = await openDatabase(
          'emp.db',
          version: 1,
          onCreate: (Database db, int version) {
            print('>>>>>>>>>> database created sucssefully');
          },
        );
      }
    } catch (e) {
      print('Errror in created database :$e');
    }
  }

  insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }
}
