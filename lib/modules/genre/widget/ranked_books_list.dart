import 'package:elkitap/modules/store/views/store_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RankedBooksList extends StatelessWidget {
  final List<Map<String, String>> books;

  const RankedBooksList({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    // Split books into groups of 3 per horizontal page
    final chunks = <List<Map<String, String>>>[];
    for (var i = 0; i < books.length; i += 3) {
      chunks.add(
        books.sublist(i, (i + 3 > books.length) ? books.length : i + 3),
      );
    }

    return SizedBox(
      height: 400, // Give fixed height so it renders properly in Column
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.95),
        scrollDirection: Axis.horizontal,
        itemCount: chunks.length,
        itemBuilder: (context, pageIndex) {
          final pageBooks = chunks[pageIndex];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: GestureDetector(
              onTap: () {
                Get.to(() => BookDetailView());
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(pageBooks.length, (index) {
                  final book = pageBooks[index];
                  final rank = pageIndex * 3 + index + 1;
                  return _buildBookRankCard(book, rank);
                }),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBookRankCard(Map<String, String> book, int rank) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Book cover
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              'assets/images/b1.png', // replace with dynamic image if available
              width: 80,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),

          // Rank number + details
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rank
                Text(
                  '$rank',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),

                // Title + Author
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book['title'] ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        book['author'] ?? '',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
