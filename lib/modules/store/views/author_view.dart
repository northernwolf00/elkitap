import 'package:elkitap/global_widgets/custom_appbar.dart';
import 'package:elkitap/modules/store/widgets/author_profil_section.dart';
import 'package:elkitap/modules/store/widgets/books_section.dart';
import 'package:flutter/material.dart';

class BookAuthorView extends StatelessWidget {
  const BookAuthorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: '', leadingText: 'Back'),
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
