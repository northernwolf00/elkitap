import 'dart:ui';

class Note {
  final String id;
  final String title;
  final String author;
  final String content;
  final String comment;
  final DateTime timestamp;
  final Color accentColor;

  Note({
    required this.id,
    required this.title,
    required this.author,
    required this.content,
    required this.comment,
    required this.timestamp,
    required this.accentColor,
  });
}