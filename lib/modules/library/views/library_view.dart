import 'package:elkitap/modules/library/widgets/collections_section.dart';
import 'package:elkitap/modules/library/widgets/current_book_section.dart';
import 'package:elkitap/modules/library/widgets/library_header.dart';
import 'package:elkitap/modules/library/widgets/recently_opened_section.dart';
import 'package:elkitap/modules/store/views/store_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLibraryViewScreen extends StatelessWidget {
  const MyLibraryViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: Theme.of(context).brightness == Brightness.dark
                        ? [
                            Color(0x001C1C1E),
                            Color(0xFF1C1C1E)
                          ] // dark mode gradient
                        : [Color(0x00E5E5EA), Color(0xFFE5E5EA)],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      LibraryHeader(),
                      SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => BookDetailView());
                        },
                        child: CurrentBookSection(discountPercentage: 45,),
                      ),
                      Divider(
                        height: 32,
                        color: Colors.grey[300],
                        thickness: 1.5,
                      ),
                      RecentlyOpenedSection(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              CollectionsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
