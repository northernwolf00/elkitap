import 'package:flutter/material.dart';

class CollectionsSection extends StatelessWidget {
  const CollectionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final collections = [
      {"icon": Icons.book_outlined, "title": "Want to Read", "count": 5},
      {"icon": Icons.headphones_outlined, "title": "Want to Listen", "count": 5},
      {"icon": Icons.sticky_note_2_outlined, "title": "Notes", "count": 2},
      {"icon": Icons.check_circle_outline, "title": "Finished", "count": 1},
      {"icon": Icons.download_outlined, "title": "Downloaded", "count": 2},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Collections",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...collections.map((item) {
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(item["icon"] as IconData, size: 24),
                title: Text(
                  item["title"] as String,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(item["count"].toString(),
                        style: const TextStyle(color: Colors.grey)),
                    const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  ],
                ),
                onTap: () {},
              ),
              const Divider(height: 1),
            ],
          );
        }),
      ],
    );
  }
}
