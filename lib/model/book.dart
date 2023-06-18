import 'package:floor/floor.dart';

@entity
class Book {
  @primaryKey
  late String id;
  late int page;
  late String title;
  late String? description;
  late String? imageSrc;

  Book({
    required this.id,
    required this.title,
    this.page = 0,
    this.description,
    this.imageSrc,
  });

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    page = json['page'];
    title = json['title'];
    description = json['description'];
    imageSrc = json['imageSrc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['page'] = page;
    data['title'] = title;
    data['description'] = description;
    data['imageSrc'] = imageSrc;
    return data;
  }

  Book copyWith({
    String? id,
    int? page,
    String? title,
    String? description,
    String? imageSrc,
  }) {
    return Book(
      id: id ?? this.id,
      page: page ?? this.page,
      title: title ?? this.title,
      description: description ?? this.description,
      imageSrc: imageSrc ?? this.imageSrc,
    );
  }
}
