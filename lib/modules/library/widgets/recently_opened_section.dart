import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/modules/genre/view/books_grid_screen_view.dart';
import 'package:elkitap/modules/store/views/store_detail_view.dart';
import 'package:elkitap/modules/store/widgets/book_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentlyOpenedSection extends StatelessWidget {
  const RecentlyOpenedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final books = [
      'assets/images/b2.png',
      'assets/images/b5.png',
      'assets/images/b3.png',
      'assets/images/b4.png',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => BooksGridScreen(title: 'recentlyOpened'.tr));
          },
          child: Text(
            'recentlyOpened'.tr,
            style: TextStyle(
              fontSize: 20,
              fontFamily: StringConstants.NewYork,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return BookCard(
                index: index,
                tabIndex: 0,
                onTap: () {
                  Get.to(() => BookDetailView());
                },
                discountPercentage: 22,
              );
            },
          ),
        ),
      ],
    );
  }
}
