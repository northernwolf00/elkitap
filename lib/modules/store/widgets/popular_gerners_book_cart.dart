import 'package:elkitap/modules/store/widgets/book_card_widget.dart';
import 'package:flutter/material.dart';

class BookCardPopular extends StatelessWidget {
  final int index;
  final int tabIndex;
  final double width;
  final double borderRadius;
  final VoidCallback? onTap;
  final int? discountPercentage;

  const BookCardPopular({
    super.key,
    required this.index,
    required this.tabIndex,
    this.width = 110,
    this.borderRadius = 8,
    this.onTap,
    this.discountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 100,
        height: 102,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (discountPercentage! > 3 && discountPercentage != null)
              Positioned(
                right: 20,
                bottom: 0,
                child: DiscountBadgeMini(
                  percentage: discountPercentage!,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: SizedBox(
                width: 82,
                height: 83,
                child: Image.asset(
                  tabIndex == 0
                      ? 'assets/images/b$index.png'
                      : 'assets/images/b${index + 2}.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
