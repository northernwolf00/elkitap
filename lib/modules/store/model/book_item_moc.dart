import 'dart:ui';

class BookItem {
  final String title;
  final String author;
  final Color color;
  final int? discountPercentage;


  BookItem({
    required this.title,
    required this.author,
    required this.color,
    this.discountPercentage,
  });
}
