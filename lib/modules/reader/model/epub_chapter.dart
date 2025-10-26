// class EpubChapter {
//   final String id;
//   final String title;
//   final String href;
//   final List<EpubChapter> subChapters;
//   final int level;

//   EpubChapter({
//     required this.id,
//     required this.title,
//     required this.href,
//     this.subChapters = const [],
//     this.level = 0,
//   });

//   EpubChapter copyWith({
//     String? id,
//     String? title,
//     String? href,
//     List<EpubChapter>? subChapters,
//     int? level,
//   }) {
//     return EpubChapter(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       href: href ?? this.href,
//       subChapters: subChapters ?? this.subChapters,
//       level: level ?? this.level,
//     );
//   }
// }