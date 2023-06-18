import 'package:bee_mark/database/db_floor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(const BookState()) {
    on<BookEventInit>(_onBookEventInit);
  }

  // AppDatabase _db = BeeMarkDB.database!;

  Future<void> _onBookEventInit(
    BookEventInit event,
    Emitter<BookState> emit,
  ) async {
    // _db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    // emit(state.copyWith(database: _db));
  }
}
