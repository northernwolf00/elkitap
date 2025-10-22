import 'package:elkitap/modules/store/widgets/featured_books_section.dart';
import 'package:elkitap/modules/store/widgets/popular_by_genre_section.dart';
import 'package:elkitap/modules/store/widgets/top_of_week_section.dart';
import 'package:flutter/material.dart';

class StoreViewScreen extends StatelessWidget {
  const StoreViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Header(),
                Row(
                  children: const [
                    Text(
                      "Books",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Audiobooks",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                FeaturedBooksSection(),
                SizedBox(height: 24),
                TopOfWeekSection(),
                SizedBox(height: 24),
                PopularByGenreSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "elkitap",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
