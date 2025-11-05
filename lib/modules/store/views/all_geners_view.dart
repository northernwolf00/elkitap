import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/modules/genre/view/genrs_page_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllGenresView extends StatelessWidget {
  const AllGenresView({super.key});

  @override
  Widget build(BuildContext context) {
    final genres = [
      'genre_biography_memories'.tr,
      'genre_business_personal_finance'.tr,
      'genre_comics_graphic_novels'.tr,
      'genre_cookbooks_food_wine'.tr,
      'genre_education'.tr,
      'genre_fiction_literature'.tr,
      'genre_health_mind_body'.tr,
      'genre_history'.tr,
      'genre_kids'.tr,
      'genre_mysteries_thrillers'.tr,
      'genre_nonfiction'.tr,
      'genre_politics_current_events'.tr,
      'genre_religion_spirituality'.tr,
      'genre_romance'.tr,
      'genre_sci_fi_fantasy'.tr,
      'genre_sports_outdoors'.tr,
      'genre_young_adult'.tr,
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
           Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Text(
              'genres'.tr,
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
