import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/modules/genre/view/genrs_page_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllGenresView extends StatelessWidget {
  const AllGenresView({super.key});

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
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title:  Text(
          'leading_text'.tr,
          style: TextStyle(
            fontSize: 17,
            fontFamily: StringConstants.SFPro,
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
                fontFamily: StringConstants.NewYork,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: genres.length,
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                thickness: 0.5,
                indent: 16,
                endIndent: 16,
              ),
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
                      fontFamily: StringConstants.SFPro,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () {
                    Get.to(GenrsDetailViewScreen());
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
