import 'package:elkitap/modules/library/widgets/collections_section.dart';
import 'package:elkitap/modules/library/widgets/current_book_section.dart';
import 'package:elkitap/modules/library/widgets/library_header.dart';
import 'package:elkitap/modules/library/widgets/recently_opened_section.dart';
import 'package:flutter/material.dart';


class MyLibraryViewScreen extends StatelessWidget {
  const MyLibraryViewScreen({super.key});

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
              LibraryHeader(),
              SizedBox(height: 24),
              CurrentBookSection(),
              Divider(height: 32),
              RecentlyOpenedSection(),
              SizedBox(height: 24),
              CollectionsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
