import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/modules/genre/view/genrs_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenresSection extends StatelessWidget {
  const GenresSection({super.key});

  @override
  Widget build(BuildContext context) {
     final genres = const [
      "genre_biography_t",
      "genre_business_t",
      "genre_comics_t",
      "genre_cookbooks_t",
      "genre_education_t",
      "genre_fiction_t",
      "genre_health_mind_body_t",
      "genre_history_t",
      "genre_kids_t",
      "genre_mysteries_t",
      "genre_nonfiction_t",
      "genre_politics_t",
      "genre_religion_t",
      "genre_romance_t",
      "genre_scifi_t",
      "genre_sports_t",
      "genre_young_adult_t",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
         "genres_title_t".tr,
          style: TextStyle(
            fontSize: 20,
            fontFamily: StringConstants.NewYork,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: genres.length,
          separatorBuilder: (_, __) =>
              Container(height: 1, color: Colors.grey[200]),
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(genres[index].tr,
              style: TextStyle(
                 fontFamily: StringConstants.SFPro,
              ),),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Get.to(GenrsDetailViewScreen());
              },
            );
          },
        ),
      ],
    );
  }
}
