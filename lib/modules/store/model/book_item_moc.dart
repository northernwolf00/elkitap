import 'dart:ui';

class BookItem {
  final String title;
  final String author;
  final Color color;
  final String? discountPercentage;


  BookItem({
    required this.title,
    required this.author,
    required this.color,
    this.discountPercentage,
  });
}
