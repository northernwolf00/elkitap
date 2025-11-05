import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/modules/genre/view/genrs_page_view.dart';
import 'package:elkitap/modules/store/views/all_geners_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenericListWidget extends StatelessWidget {
  const GenericListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> genres = [
      'genre_biography_t', // 'Biography & Memories'
      'genre_business_t', // 'Business & Personal Finance'
      'genre_education_t', // 'Education'
      'genre_fiction_t', // 'Fiction & Literature'
      'genre_history_t', // 'History'
      'all_genres_t',
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "genres_title_t".tr,
            style: TextStyle(
                fontSize: 18,
                fontFamily: StringConstants.NewYork,
                fontWeight: FontWeight.bold),
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
                    item.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: StringConstants.SFPro,
                    ),
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
                    if (item == 'all_genres_t') {
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
