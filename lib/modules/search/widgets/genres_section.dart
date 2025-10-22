import 'package:flutter/material.dart';

class GenresSection extends StatelessWidget {
  const GenresSection({super.key});

  @override
  Widget build(BuildContext context) {
    final genres = [
      "Biography & Memories",
      "Business & Personal Finance",
      "Comics & Graphic Novels",
      "Cookbooks, Food & Wine",
      "Education",
      "Fiction & Literature",
      "Health, Mind & Body",
      "History",
      "Kids",
      "Mysteries & Thrillers",
      "Nonfiction",
      "Politics & Current Events",
      "Religion & Spirituality",
      "Romance",
      "Sci-Fi & Fantasy",
      "Sports & Outdoors",
      "Young Adult",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Genres",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'New York',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: genres.length,
          separatorBuilder:
              (_, __) => Container(height: 1, color: Colors.grey[200]),
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(genres[index]),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            );
          },
        ),
      ],
    );
  }
}
