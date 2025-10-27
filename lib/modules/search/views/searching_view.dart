import 'package:elkitap/modules/search/widgets/recently_search_widget.dart';
import 'package:elkitap/modules/search/widgets/result_section.dart';
import 'package:elkitap/modules/search/widgets/searching_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchingViewScreen extends StatefulWidget {
  const SearchingViewScreen({super.key});

  @override
  State<SearchingViewScreen> createState() => _SearchingViewScreenState();
}

class _SearchingViewScreenState extends State<SearchingViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchingHeader(),
              const SizedBox(height: 30),
              RecentlySearchedScreen(),
               const SizedBox(height: 30),
              ResultSectionScreen()
              // RecentlyViewedSection(),
              // SizedBox(height: 24),
              // GenresSection(),
            ],
          ),
        ),
      ),
    );
  }
}