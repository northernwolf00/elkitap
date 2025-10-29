import 'package:elkitap/modules/genre/view/genrs_page_view.dart';
import 'package:elkitap/modules/store/views/all_geners_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenericListWidget extends StatelessWidget {
  const GenericListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> genres = [
      'Biography & Memories',
      'Business & Personal Finance',
      'Education',
      'Fiction & Literature',
      'History',
      'All Genres',
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Genres",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          ...genres.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,

                  title: Text(
                    item,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 22,
                        color: Colors.grey[200],
                      ),
                    ],
                  ),
                  onTap: () {
                    if (item == 'All Genres') {
                      Get.to(AllGenresView());
                    } else {
                      Get.to(GenrsDetailViewScreen());
                    }
                  },
                ),
                // Only show divider if not the last item
                if (index != genres.length - 1)
                  Container(height: 1, color: Colors.grey[200]),
              ],
            );
          }),
        ],
      ),
    );
  }
}
