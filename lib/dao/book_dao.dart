// dao/person_dao.dart

import 'package:bee_mark/model/book.dart';
import 'package:floor/floor.dart';

@dao
abstract class BookDao {
  @Query('SELECT * FROM Book')
  Future<List<Book>> findAllBook();

  @Query('SELECT name FROM Book')
  Stream<List<String>> findAllBookName();

  @Query('SELECT * FROM Book WHERE id = :id')
  Stream<Book?> findBookById(int id);

  @update
  Future<void> updateBook(Book book);

  @delete
  Future<void> deleteBook(Book book);

  @insert
  Future<void> insertBook(Book person);
}
