import 'package:bee_mark/screen/book_add/book_add.dart';
import 'package:flutter/cupertino.dart';

Route<dynamic>? routeGenerator(RouteSettings settings) {
  switch (settings.name) {
    case '/book_add':
      return CupertinoPageRoute(
          builder: (_) => const BookAddPage(), settings: settings);
  }
  return null;
}
