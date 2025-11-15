import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/modules/store/widgets/book_card_widget.dart';
import 'package:flutter/material.dart';

class BookCardGridView extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final VoidCallback? onTap;
  final int? discountPercentage;

  const BookCardGridView({
    super.key,
    required this.image,
    required this.title,
    required this.author,
    this.onTap,
    this.discountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Book cover
          Expanded(
            child: SizedBox(
              height: 170,
              child: Stack(
                children: [
                  if (discountPercentage != null && discountPercentage! > 3)
                    Positioned(
                      right: 15,
                      bottom: 0,
                      child: DiscountBadge(
                        percentage: discountPercentage!,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Image.asset(
                      height: 220,
                      width: 148,
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 3),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: StringConstants.SFPro,
              fontSize: 17,
            ),
          ),

          const SizedBox(height: 2),

          // Author
          Text(
            author,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey[600],
              fontFamily: StringConstants.SFPro,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
