part of 'book_add_bloc.dart';

class BookAddState {
  const BookAddState({
    this.id,
    this.book,
    this.fieldList,
    this.isDone = false,
    this.isEditing = false,
  });

  final List<
      ({
        Symbol fieldSymbol,
        String name,
        TextEditingController controller
      })>? fieldList;

  final String? id;
  final Book? book;
  final bool isDone;
  final bool isEditing;

  BookAddState copyWith({
    List<({Symbol fieldSymbol, String name, TextEditingController controller})>?
        fieldList,
    String? id,
    bool? isDone,
    bool? isEditing,
    Book? book,
  }) {
    return BookAddState(
      id: id ?? this.id,
      book: book ?? this.book,
      fieldList: fieldList ?? this.fieldList,
      isDone: isDone ?? this.isDone,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}
