import 'package:elkitap/modules/store/widgets/book_cart_vertical.dart';
import 'package:elkitap/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class TopOfWeekSection extends StatelessWidget {
  const TopOfWeekSection({super.key});

  @override
  Widget build(BuildContext context) {
    final books = [
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
              Get.toNamed(Routes.GENRS_LIST);
            },
            child: const Text(
              "Top of the week",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'New York',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: List.generate(books.length, (index) {
              final book = books[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: BookVerticalCart(
                  index: index,
                  book: book,
                  onTap: () {
                    Get.toNamed('/book-detail');
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
