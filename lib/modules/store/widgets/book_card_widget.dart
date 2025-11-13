import 'package:flutter/material.dart';



class BookCard extends StatelessWidget {
  final int index;
  final int tabIndex;
  final double width;
  final double borderRadius;
  final VoidCallback? onTap;
  final String? discountPercentage;

  const BookCard({
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
        width: 144,
        height: 180,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
          if (discountPercentage != null)
              Positioned(
                right: 30,
                bottom: 0,
                child: DiscountBadge(
                  percentage: discountPercentage!,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                width: 134,
                height: 160,
                child: Image.asset(
                  tabIndex == 0
                      ? 'assets/images/b$index.png'
                      : 'assets/images/b${index + 2}.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
        
           
            
          ],
        ),
      ),
    );
  }
}



class DiscountBadge extends StatelessWidget {
  final String percentage;

  const DiscountBadge({
    super.key,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
   
    return Container(
      width: 32,
      height: 37, 
      
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/bg2.png',
        ),
        fit: BoxFit.cover), 
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          '$percentage%', 
          textAlign: TextAlign.center,
          style: const TextStyle(
            
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}