import 'package:flutter/material.dart';

class AllGenresView extends StatelessWidget {
  const AllGenresView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genres = [
      'Biography & Memories',
      'Business & Personal Finance',
      'Comics & Graphic Novels',
      'Cookbooks, Food & Wine',
      'Education',
      'Fiction & Literature',
      'Health, Mind & Body',
      'History',
      'Kids',
      'Mysteries & Thrillers',
      'Nonfiction',
      'Politics & Current Events',
      'Religion & Spirituality',
      'Romance',
      'Sci-Fi & Fantasy',
      'Sports & Outdoors',
      'Young Adult',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Back',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        titleSpacing: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Text(
              'Genres',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: genres.length,
              separatorBuilder:
                  (context, index) =>
                      const Divider(height: 1, thickness: 0.5, indent: 16),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  title: Text(
                    genres[index],
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () {
                    // Navigate to genre detail page
                    print('Tapped on ${genres[index]}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
