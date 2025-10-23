import 'package:flutter/material.dart';

// Main Screen
class BookAuthorView extends StatelessWidget {
  const BookAuthorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const AuthorAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const AuthorProfileSection(),
                    const SizedBox(height: 24),
                    BooksSection(),
                    const SizedBox(height: 24),
                    AudiobooksSection(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}