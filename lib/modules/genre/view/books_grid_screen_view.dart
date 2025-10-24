import 'package:elkitap/global_widgets/custom_appbar.dart';
import 'package:elkitap/modules/genre/widget/book_grid_cart.dart';
import 'package:elkitap/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BooksGridScreen extends StatelessWidget {
  final List<Map<String, String>> books = [
    {
      'title': '12 Rules for Life',
      'author': 'Rebecca Roanhorse',
      'image': 'assets/images/b3.png',
    },
    {
      'title': 'Stop Overthinking',
      'author': 'Rebecca Roanhorse',
      'image': 'assets/images/b2.png',
    },
    {
      'title': 'Power',
      'author': 'Rebecca Roanhorse',
      'image': 'assets/images/b3.png',
    },
    {
      'title': 'Falling Bodies',
      'author': 'Rebecca Roanhorse',
      'image': 'assets/images/b4.png',
    },
    {
      'title': 'Falling Bodies',
      'author': 'Rebecca Roanhorse',
      'image': 'assets/images/b7.png',
    },
    {
      'title': 'How It Unfolds',
      'author': 'Rebecca Roanhorse',
      'image': 'assets/images/b3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Fiction & Literature', leadingText: 'Back'),
      body: GridView.builder(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: 40,
        ),
        shrinkWrap: true,
        itemCount: books.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          // crossAxisSpacing: 16,
          childAspectRatio: 0.70,
        ),
        itemBuilder: (context, index) {
          final book = books[index];
          return BookCardGridView(
            image: book['image']!,
            title: book['title']!,
            author: book['author']!,
            onTap: () {
              Get.toNamed(Routes.BOOK_DETAIL);
            },
          );
        },
      ),
    );
  }
}
