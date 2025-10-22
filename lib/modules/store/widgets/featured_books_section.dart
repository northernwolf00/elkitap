import 'package:flutter/material.dart';

class FeaturedBooksSection extends StatelessWidget {
  final int tabIndex;
  FeaturedBooksSection({required this.tabIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tabIndex == 0 ? "FEATURED BOOKS" : 'FEATURED AUDIOBOOKS',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          const Text(
            "We recommend",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 110,
                    child: Image.asset(
                      tabIndex == 0
                          ? 'assets/images/b$index.png'
                          : 'assets/images/b${index + 2}.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
