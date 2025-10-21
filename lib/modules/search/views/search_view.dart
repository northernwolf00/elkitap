import 'package:elkitap/modules/search/widgets/genres_section.dart';
import 'package:elkitap/modules/search/widgets/recently_viewed_section.dart';
import 'package:elkitap/modules/search/widgets/search_header.dart';
import 'package:flutter/material.dart';


class SearchViewScreen extends StatelessWidget {
  const SearchViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SearchHeader(),
              SizedBox(height: 24),
              RecentlyViewedSection(),
              SizedBox(height: 24),
              GenresSection(),
            ],
          ),
        ),
      ),
    );
  }
}
