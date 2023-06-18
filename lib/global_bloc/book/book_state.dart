part of 'book_bloc.dart';

class BookState {
  const BookState({this.database});

  final AppDatabase? database;

  BookState copyWith({AppDatabase? database}) {
    return BookState(database: database ?? this.database);
  }
}
