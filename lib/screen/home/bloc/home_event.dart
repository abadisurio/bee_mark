part of 'home_bloc.dart';

abstract class HomeEvent {}

class HomeEventLoadBookList extends HomeEvent {}

class HomeEventDeleteBook extends HomeEvent {
  HomeEventDeleteBook({
    required this.book,
  });
  final Book book;
}

class HomeEventUpdateBookPage extends HomeEvent {
  HomeEventUpdateBookPage({
    required this.book,
    required this.page,
  });
  final Book book;
  final int page;
}
