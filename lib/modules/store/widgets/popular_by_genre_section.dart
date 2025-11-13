import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/modules/genre/view/books_grid_screen_view.dart';
import 'package:elkitap/modules/store/views/store_detail_view.dart';
import 'package:elkitap/modules/store/widgets/book_card_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularByGenreSection extends StatelessWidget {
  const PopularByGenreSection({super.key});

  @override
  Widget build(BuildContext context) {
    final genres = [
      'genre_fiction_t', // "Fiction & Literature"
      'genre_nonfiction_t', // "Nonfiction"
      'genre_science_fiction_t', // "Science Fiction"
      'genre_fantasy_t', // "Fantasy"
      'genre_mystery_thriller_t',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),
          Text(
            "popular_by_genre_t".tr,
            style: TextStyle(
              fontSize: 20,
              fontFamily: StringConstants.NewYork,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: genres.map((genre) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 22),
                    Container(height: 1.5, color: Colors.grey[300]),
                    const SizedBox(height: 22),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => BooksGridScreen(title: genre.tr));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            genre.tr,
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: StringConstants.NewYork,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 150,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          return BookCard(
                            index: index,
                            tabIndex: 0,
                            onTap: () {
                              Get.to(() => BookDetailView());
                            },
                            discountPercentage: 23,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
