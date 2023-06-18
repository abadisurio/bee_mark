// database.dart

// required package imports
import 'dart:async';
import 'package:bee_mark/dao/book_dao.dart';
import 'package:bee_mark/model/book.dart';
import 'package:floor/floor.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;
part 'db_floor.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Book])
abstract class AppDatabase extends FloorDatabase {
  BookDao get bookDao;
}
