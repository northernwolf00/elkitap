import 'package:elkitap/modules/genre/view/books_grid_screen_view.dart';
import 'package:elkitap/modules/store/views/store_detail_view.dart';
import 'package:elkitap/modules/store/widgets/book_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeaturedBooksSection extends StatelessWidget {
  final int tabIndex;
  FeaturedBooksSection({required this.tabIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tabIndex == 0 ? "FEATURED BOOKS" : 'FEATURED AUDIOBOOKS',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              Get.to(BooksGridScreen(title: "We recommend",));
            },
            child: const Text(
              "We recommend",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return BookCard(
                  index: index,
                  tabIndex: 0,
                  onTap: () {
                     Get.to(BookDetailView());
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
