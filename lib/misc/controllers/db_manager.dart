import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseMannager {
  Database? _dataBase;

  Future<Database> get dataBase async {
    _dataBase = _dataBase ?? await initDataBase();
    return _dataBase!;
  }

  Future<Database> initDataBase() async {
    String path = join(await getDatabasesPath(), 'users.db');
    return await openDatabase(path, version: 1, onCreate: createDataBase);
  }

  Future<void> createDataBase(Database db, int version) async {
    await db.execute('''
         CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            password TEXT
         )     
      ''');
  }
}
