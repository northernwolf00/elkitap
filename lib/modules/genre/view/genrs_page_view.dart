import 'package:elkitap/global_widgets/custom_appbar.dart';
import 'package:elkitap/modules/store/widgets/featured_books_section.dart';
import 'package:elkitap/modules/store/widgets/popular_by_genre_section.dart';
import 'package:elkitap/modules/store/widgets/top_of_week_section.dart';
import 'package:flutter/material.dart';

class GenrsDetailViewScreen extends StatefulWidget {
  const GenrsDetailViewScreen({super.key});

  @override
  State<GenrsDetailViewScreen> createState() => _GenrsDetailViewScreenState();
}

class _GenrsDetailViewScreenState extends State<GenrsDetailViewScreen> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: '', leadingText: 'Back'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 14),
                _Header(),

                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0x00E5E5EA), Color(0xFFE5E5EA)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      FeaturedBooksSection(tabIndex: selectedTab),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0x00E5E5EA), Color(0xFFE5E5EA)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: TopOfWeekSection(),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0x00E5E5EA), Color(0xFFE5E5EA)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const PopularByGenreSection(),
                ),

                // Container(
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       colors: [Color(0x00E5E5EA), Color(0xFFE5E5EA)],
                //       begin: Alignment.topCenter,
                //       end: Alignment.bottomCenter,
                //     ),
                //   ),
                //   child: ListProfileWidget(),
                // ),
                // GenericListWidget(),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: const Text(
            "Health, Mind & Body",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
