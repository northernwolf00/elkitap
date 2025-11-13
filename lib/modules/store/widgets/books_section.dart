import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/modules/genre/view/books_grid_screen_view.dart';
import 'package:elkitap/modules/store/model/book_item_moc.dart';
import 'package:elkitap/modules/store/views/store_detail_view.dart';
import 'package:elkitap/modules/store/widgets/book_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BooksSection extends StatelessWidget {
  final List<BookItem> books = [
    BookItem(
      title: 'The Subtle Art of Not Giving a F*ck',
      author: 'Mark Manson',
      color: Colors.orange,
      discountPercentage: 4,
    ),
    BookItem(
      title: '12 Rules for Life',
      author: 'Jordan B. Peterson',
      color: Colors.white,
      discountPercentage: 12,
    ),
    BookItem(
      title: 'Stop Overthinking',
      author: 'Nick Trenton',
      color: Colors.red,
      discountPercentage: 23,
    ),
    BookItem(
      title: 'Atomic Habits',
      author: 'James Clear',
      color: Colors.white,
      discountPercentage: 43,
    ),
  ];

  BooksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
            title: 'books_t'.tr,
            onTap: () {
              Get.to(() => BooksGridScreen(
                    title: 'books_t'.tr,
                  ));
            }),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: books.length,
            itemBuilder: (context, index) {
              return BookCard(
                index: index,
                tabIndex: 0,
                onTap: () {
                  Get.to(() => BookDetailView());
                },
                discountPercentage: 45,
              );
            },
          ),
        ),
      ],
    );
  }
}

// Audiobooks Section
class AudiobooksSection extends StatelessWidget {
  final List<BookItem> audiobooks = [
    BookItem(
      title: 'The Subtle Art of Not Giving a F*ck',
      author: 'Mark Manson',
      color: Colors.orange,
    ),
    BookItem(
      title: 'Atomic Habits',
      author: 'James Clear',
      color: Colors.white,
    ),
    BookItem(
      title: '12 Rules for Life',
      author: 'Jordan B. Peterson',
      color: Colors.white,
    ),
    BookItem(
      title: 'Falling',
      author: 'Rebecca Roanhorse',
      color: Colors.black,
    ),
  ];

  AudiobooksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
            title: 'Audiobooks',
            onTap: () {
              Get.to(() => BooksGridScreen(
                    title: 'Audiobooks',
                  ));
            }),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: audiobooks.length,
            itemBuilder: (context, index) {
              return BookCard(
                index: index,
                tabIndex: 0,
                onTap: () {
                  Get.to(() => BookDetailView());
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// Section Header Component
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SectionHeader({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(BooksGridScreen(
          title: title,
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 24,
                  fontFamily: StringConstants.NewYork,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: onTap,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
