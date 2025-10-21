import 'package:flutter/material.dart';

class RecentlyOpenedSection extends StatelessWidget {
  const RecentlyOpenedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final books = [
      'assets/books/falling_bodies.png',
      'assets/books/falling_bodies_alt.png',
      'assets/books/12_rules.png',
      'assets/books/subtle_art.png',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recently Opened",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 100,
                  color: Colors.grey.shade200,
                  child: Image.asset(books[index], fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
