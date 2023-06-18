import 'package:bee_mark/database/db_floor.dart';

class BeeMarkDB {
  static AppDatabase? database;

  static Future<void> init() async {
    database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  //   /// singleton pattern
  // BeeMarkDB._internal() {
  //   // if (_database == null) database;
  // }
  // static final BeeMarkDB instance = BeeMarkDB._internal();

  // /// sqflite datbase instance
  // static AppDatabase? _database;

  // /// gets database instance
  // Future<AppDatabase> get database async {
  //   if (_database != null) return _database!;
  //   _database = await _initDB();
  //   return _database!;
  // }

  // /// initialize the database
  // Future<AppDatabase> _initDB() async {
  //   print('createing databse');
  //   final dbPath = await getDatabasesPath();
  //   final path = join(dbPath, 'taskino.db');
  //   print('path is $path');
  //   return await openDatabase(path,
  //       version: 1, onCreate: _onCreate, onConfigure: _onConfigure);
  // }
}
