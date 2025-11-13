import 'package:elkitap/modules/store/widgets/book_card_widget.dart';
import 'package:flutter/material.dart';

class CurrentBookSection extends StatelessWidget {
    final String? discountPercentage;
  const CurrentBookSection({super.key,
  this.discountPercentage, });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: Stack(
        children: [
           if (discountPercentage != null)
           
            Positioned(
              bottom: 0,
              right: 22,
             
              child: DiscountBadge(
                percentage: discountPercentage!,
              ),
            ),
          Container(
            height: 180,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
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