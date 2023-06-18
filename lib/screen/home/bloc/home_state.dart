part of 'home_bloc.dart';

class HomeState {
  const HomeState({this.bookList});

  final List<Book>? bookList;

  HomeState copyWith({List<Book>? bookList}) {
    return HomeState(bookList: bookList ?? this.bookList);
  }
}
