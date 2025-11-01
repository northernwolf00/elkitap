import 'package:elkitap/core/constants/string_constants.dart';
import 'package:flutter/material.dart';

class BookCardGridView extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final VoidCallback? onTap;

  const BookCardGridView({
    super.key,
    required this.image,
    required this.title,
    required this.author,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Book cover
          AspectRatio(
            aspectRatio: 0.9,
            child: ClipRRect(child: Image.asset(image, fit: BoxFit.cover)),
          ),

          const SizedBox(height: 8),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600, 
             fontFamily: StringConstants.SFPro,
            fontSize: 17),
          ),

          const SizedBox(height: 2),

          // Author
          Text(
            author,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600],
             fontFamily: StringConstants.SFPro,
             fontSize: 12),
          ),
        ],
      ),
    );
  }
}
