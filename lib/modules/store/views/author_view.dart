import 'package:elkitap/global_widgets/custom_appbar.dart';
import 'package:elkitap/modules/store/widgets/author_profil_section.dart';
import 'package:elkitap/modules/store/widgets/books_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookAuthorView extends StatelessWidget {
  const BookAuthorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  CustomAppBar(title: '', leadingText: 'leading_text'.tr),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthorProfileSection(),
              SizedBox(height: 24),
              BooksSection(),
              SizedBox(height: 24),
              AudiobooksSection(),
            ],
          ),
        ),
      ),
    );
  }
}
