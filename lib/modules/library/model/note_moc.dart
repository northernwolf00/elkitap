import 'dart:ui';

class NoteItem {
  final String id;
  final String title;
  final String author;
  final String quote;
  final String comment;
  final String date;
  final Color color;

  NoteItem({
    required this.id,
    required this.title,
    required this.author,
    required this.quote,
    required this.comment,
    required this.date,
    required this.color,
  });
}

