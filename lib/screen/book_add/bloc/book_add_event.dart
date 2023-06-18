part of 'book_add_bloc.dart';

abstract class BookAddEvent {
  const BookAddEvent();
}

class BookAddEventPopulateFieldList extends BookAddEvent {}

class BookAddEventAddBook extends BookAddEvent {}

class BookAddEventEditBook extends BookAddEvent {}
