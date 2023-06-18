import 'package:bee_mark/database/db_beemark.dart';
import 'package:bee_mark/model/book.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_add_event.dart';
part 'book_add_state.dart';

class BookAddBloc extends Bloc<BookAddEvent, BookAddState> {
  BookAddBloc() : super(const BookAddState()) {
    on<BookAddEventPopulateFieldList>(_onBookAddEventPopulateFieldList);
    on<BookAddEventAddBook>(_onBookAddEventAddBook);
    on<BookAddEventEditBook>(_onBookAddEventEditBook);
  }

  final _db = BeeMarkDB.database!;
// final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  void _onBookAddEventPopulateFieldList(
    BookAddEventPopulateFieldList event,
    Emitter<BookAddState> emit,
  ) {
    emit(
      state.copyWith(
        fieldList: [
          (
            fieldSymbol: const Symbol('title'),
            name: 'Title *',
            controller: TextEditingController()
          ),
          (
            fieldSymbol: const Symbol('description'),
            name: 'Notes',
            controller: TextEditingController()
          ),
          (
            fieldSymbol: const Symbol('imageSrc'),
            name: 'Cover Url',
            controller: TextEditingController()
          ),
        ],
      ),
    );
  }

  Future<void> _onBookAddEventAddBook(
    BookAddEventAddBook event,
    Emitter<BookAddState> emit,
  ) async {
    if (state.fieldList == null) return;

    await _db.bookDao.insertBook(state.book!);
    emit(state.copyWith(isDone: true));
  }

  Future<void> _onBookAddEventEditBook(
    BookAddEventEditBook event,
    Emitter<BookAddState> emit,
  ) async {
    if (state.fieldList == null) return;

    final parameterMap = {
      for (var element in state.fieldList!
          .map((e) => MapEntry(e.fieldSymbol, e.controller.text)))
        element.key: element.value
    };
    final book = Function.apply(
      Book.new,
      [],
      {...parameterMap, #id: DateTime.now().toIso8601String()},
    ) as Book;
    emit(state.copyWith(book: book));
  }
}
