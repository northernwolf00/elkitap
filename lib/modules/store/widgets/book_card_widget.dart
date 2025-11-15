import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final int index;
  final int tabIndex;
  final double width;
  final double borderRadius;
  final VoidCallback? onTap;
  final int? discountPercentage;

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
        height: 204,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (discountPercentage! > 3 && discountPercentage != null)
              Positioned(
                right: 20,
                bottom: 0,
                child: DiscountBadge(
                  percentage: discountPercentage!,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                width: 144,
                height: 184,
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

class DiscountBadge extends StatelessWidget {
  final int percentage;

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
        image: DecorationImage(
            image: AssetImage(
              'assets/images/bg2.png',
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

class DiscountBadgeMini extends StatelessWidget {
  final int percentage;

  const DiscountBadgeMini({
    super.key,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 20,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/images/bg2.png',
            ),
            fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          '$percentage%',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 6,
          ),
        ),
      ),
    );
  }
}
