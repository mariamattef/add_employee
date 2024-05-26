import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class EmployeeDb {
  static EmployeeDb? _instance;
  Database? db;

  EmployeeDb._();

  factory EmployeeDb() {
    _instance ??= EmployeeDb._();
    return _instance!;
  }

  Future<void> createTables() async {
    try {
      await db!.execute('''
        create table if not exists 'employee' (
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

  Future<void> init() async {
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
      createTables();
    } catch (e) {
      print('Errror in created database :$e');
    }
  }

  Future<int> insertData(String sql) async {
    int response = await db!.rawInsert(sql);
    return response;
  }

  Future<List<Map<String, dynamic>>> getData(String sql) async {
    List<Map<String, dynamic>> response = await db!.rawQuery(sql);
    return response;
  }

  Future<int> deleteData(String sql) async {
    int response = await db!.rawDelete(sql);
    return response;
  }
}
