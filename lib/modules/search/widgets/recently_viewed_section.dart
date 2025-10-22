import 'package:flutter/material.dart';

class RecentlyViewedSection extends StatelessWidget {
  const RecentlyViewedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final books = [
      'assets/images/b1.png',
      'assets/images/b2.png',
      'assets/images/b4.png',
      'assets/images/b3.png',
      'assets/images/b5.png',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Recently Viewed",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'New York',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Clear",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 110,

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
