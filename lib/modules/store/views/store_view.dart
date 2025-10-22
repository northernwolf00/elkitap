import 'package:elkitap/global_widgets/custom_tabbar.dart';
import 'package:elkitap/modules/store/widgets/featured_books_section.dart';
import 'package:elkitap/modules/store/widgets/generic_list_widget.dart';
import 'package:elkitap/modules/store/widgets/list_profile_widget.dart';
import 'package:elkitap/modules/store/widgets/popular_by_genre_section.dart';
import 'package:elkitap/modules/store/widgets/top_of_week_section.dart';
import 'package:flutter/material.dart';

class StoreViewScreen extends StatefulWidget {
  const StoreViewScreen({super.key});

  @override
  State<StoreViewScreen> createState() => _StoreViewScreenState();
}

class _StoreViewScreenState extends State<StoreViewScreen> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                CustomTabBar(
                  onTabChanged: (index) {
                    setState(() {
                      selectedTab = index;
                    });
                  },
                ),
                if (selectedTab == 0) ...[
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

                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0x00E5E5EA), Color(0xFFE5E5EA)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: ListProfileWidget(),
                  ),
                  GenericListWidget(),
                ] else ...[
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

                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0x00E5E5EA), Color(0xFFE5E5EA)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: ListProfileWidget(),
                  ),
                  GenericListWidget(),
                ],
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
            "elkitap",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
