import 'package:elkitap/modules/search/widgets/genres_section.dart';
import 'package:elkitap/modules/search/widgets/recently_viewed_section.dart';
import 'package:elkitap/modules/search/widgets/search_header.dart';
import 'package:flutter/material.dart';

class SearchViewScreen extends StatelessWidget {
  const SearchViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchHeader(),
              SizedBox(height: 30),
              RecentlyViewedSection(
                discountPercentage: 12,
              ),
              SizedBox(height: 24),
              GenresSection(),
            ],
          ),
        ),
      ),
    );
  }
}
