import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final int index;
  final int tabIndex;
  final double width;
  final double borderRadius;
  final VoidCallback? onTap;

  const BookCard({
    super.key,
    required this.index,
    required this.tabIndex,
    this.width = 110,
    this.borderRadius = 8,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: SizedBox(
          width: width,
          child: Image.asset(
            tabIndex == 0
                ? 'assets/images/b$index.png'
                : 'assets/images/b${index + 2}.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
