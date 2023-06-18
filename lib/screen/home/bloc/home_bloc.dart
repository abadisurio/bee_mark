import 'package:bee_mark/database/db_beemark.dart';
import 'package:bee_mark/model/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeEventLoadBookList>(_onHomeEventLoadBookList);
    on<HomeEventDeleteBook>(_onHomeEventDeleteBook);
    on<HomeEventUpdateBookPage>(_onHomeEventUpdateBookPage);
  }

  Future<void> _onHomeEventLoadBookList(
    HomeEventLoadBookList event,
    Emitter<HomeState> emit,
  ) async {
    final db = BeeMarkDB.database;

    final bookList = await db!.bookDao.findAllBook();

    emit(
      state.copyWith(bookList: bookList),
    );
  }

  Future<void> _onHomeEventDeleteBook(
    HomeEventDeleteBook event,
    Emitter<HomeState> emit,
  ) async {
    final db = BeeMarkDB.database;

    await db!.bookDao.deleteBook(event.book);

    emit(
      state.copyWith(
          bookList: state.bookList!.fold(
              [],
              (previousValue, element) => [
                    ...previousValue ?? [],
                    if (element.id == event.book.id) element
                  ])),
    );
    add(HomeEventLoadBookList());
  }

  Future<void> _onHomeEventUpdateBookPage(
    HomeEventUpdateBookPage event,
    Emitter<HomeState> emit,
  ) async {
    final db = BeeMarkDB.database;
    final book = event.book.copyWith(page: event.page);

    await db!.bookDao.updateBook(book);

    emit(
      state.copyWith(
          bookList: state.bookList!.fold(
              [],
              (previousValue, element) => [
                    ...previousValue ?? [],
                    if (element.id == event.book.id) book
                  ])),
    );
    add(HomeEventLoadBookList());
  }
}
