import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/modules/store/views/store_detail_view.dart';
import 'package:elkitap/modules/store/widgets/book_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentlyViewedSection extends StatelessWidget {
  final int? discountPercentage;
  RecentlyViewedSection({required this.discountPercentage, super.key});

  @override
  Widget build(BuildContext context) {
    final books = [
      'assets/images/b1.png',
      'assets/images/b2.png',
      'assets/images/b4.png',
      'assets/images/b3.png',
      'assets/images/b5.png',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'recently_viewed_t'.tr,
              style: TextStyle(
                fontSize: 20,
                fontFamily: StringConstants.NewYork,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "clear".tr,
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: StringConstants.SFPro,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => BookDetailView());
                },
                child: SizedBox(
                  height: 175,
                  child: Stack(
                    children: [
                      if (discountPercentage! > 3 && discountPercentage != null)
                        Positioned(
                          bottom: 0,
                          right: 12,
                          child: DiscountBadge(
                            percentage: discountPercentage!,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: ClipRRect(
                          child: SizedBox(
                            width: 100,
                            height: 145,
                            child: Image.asset(books[index], fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
