import 'package:elkitap/modules/reader/model/book_details_entity.dart';

class MockBookData {
  // Single mock book
  static BookDetailsEntity get sampleBook => BookDetailsEntity(
        id: 1,
        name: 'The Great Adventure',
        slug: 'the-great-adventure',
        totalPages: 320,
        image: BookImage(url: 'https://picsum.photos/seed/book1/200/300'),
        electronic: 'epub',
      );

  // Multiple mock books
  static List<BookDetailsEntity> get sampleBooks => [
        BookDetailsEntity(
          id: 1,
          name: 'The Great Adventure',
          slug: 'the-great-adventure',
          totalPages: 320,
          image: BookImage(url: 'https://picsum.photos/seed/book1/200/300'),
          electronic: 'epub',
        ),
        BookDetailsEntity(
          id: 2,
          name: 'Mystery of the Lost City',
          slug: 'mystery-of-the-lost-city',
          totalPages: 280,
          image: BookImage(url: 'https://picsum.photos/seed/book2/200/300'),
          electronic: 'epub',
        ),
        BookDetailsEntity(
          id: 3,
          name: 'Journey Through Time',
          slug: 'journey-through-time',
          totalPages: 410,
          image: BookImage(url: 'https://picsum.photos/seed/book3/200/300'),
          electronic: 'epub',
        ),
        BookDetailsEntity(
          id: 4,
          name: 'The Last Kingdom',
          slug: 'the-last-kingdom',
          totalPages: 350,
          image: BookImage(url: 'https://picsum.photos/seed/book4/200/300'),
          electronic: 'epub',
        ),
        BookDetailsEntity(
          id: 5,
          name: 'Secrets of the Ocean',
          slug: 'secrets-of-the-ocean',
          totalPages: 290,
          image: BookImage(url: 'https://picsum.photos/seed/book5/200/300'),
          electronic: 'epub',
        ),
      ];

  // Get book by ID
  static BookDetailsEntity getBookById(int id) {
    try {
      return sampleBooks.firstWhere((book) => book.id == id);
    } catch (e) {
      return sampleBook; // Return default if not found
    }
  }

  // Get book by slug
  static BookDetailsEntity getBookBySlug(String slug) {
    try {
      return sampleBooks.firstWhere((book) => book.slug == slug);
    } catch (e) {
      return sampleBook; // Return default if not found
    }
  }
}
