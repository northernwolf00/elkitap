import 'package:flutter/material.dart';

class TopOfWeekSection extends StatelessWidget {
  const TopOfWeekSection({super.key});

  @override
  Widget build(BuildContext context) {
    final books = [
      {"title": "Falling bodies", "author": "Rebecca Rainhorse"},
      {"title": "Falling bodies", "author": "Rebecca Rainhorse"},
      {"title": "Falling bodies", "author": "Rebecca Rainhorse"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),
          const Text(
            "Top of the week",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'New York',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: List.generate(books.length, (index) {
              final book = books[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Text(
                      "${index + 1}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 60,
                      width: 40,
                      child: Image.asset(
                        'assets/images/b$index.png',
                        fit: BoxFit.cover,
                      ),
                      margin: const EdgeInsets.only(right: 12),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book["title"]!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            book["author"]!,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
