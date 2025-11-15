import 'package:elkitap/modules/store/widgets/book_card_widget.dart';
import 'package:flutter/material.dart';

class CurrentBookSection extends StatelessWidget {
  final int? discountPercentage;
  const CurrentBookSection({
    super.key,
    this.discountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          if (discountPercentage! > 3 && discountPercentage != null)
            Positioned(
              bottom: 5,
              right: 22,
              child: DiscountBadge(
                percentage: discountPercentage!,
              ),
            ),
          Container(
            height: 180,
            width: 120,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/b2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
