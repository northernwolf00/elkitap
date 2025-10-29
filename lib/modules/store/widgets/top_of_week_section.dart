import 'package:elkitap/modules/genre/view/books_grid_screen_view.dart';
import 'package:elkitap/modules/genre/widget/ranked_books_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopOfWeekSection extends StatelessWidget {
  const TopOfWeekSection({super.key});

  @override
  Widget build(BuildContext context) {
    final books = [
      {"title": "Falling bodies", "author": "Rebecca Rainhorse"},
      {"title": "Falling bodies", "author": "Rebecca Rainhorse"},
      {"title": "Falling bodies", "author": "Rebecca Rainhorse"},
      {"title": "Falling bodies", "author": "Rebecca Rainhorse"},
      {"title": "Falling bodies", "author": "Rebecca Rainhorse"},
      {"title": "Falling bodies", "author": "Rebecca Rainhorse"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),
          GestureDetector(
            onTap: () {
              Get.to(() => BooksGridScreen(
                    title: "Top of the week",
                  ));
            },
            child: const Text(
              "Top of the week",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'NewYork',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          RankedBooksList(books: books),
          // Column(
          //   children: List.generate(books.length, (index) {
          //     final book = books[index];
          //     return Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 6),
          //       child: BookVerticalCart(
          //         index: index,
          //         book: book,
          //         onTap: () {
          //           Get.toNamed('/book-detail');
          //         },
          //       ),
          //     );
          //   }),
          // ),
        ],
      ),
    );
  }
}
