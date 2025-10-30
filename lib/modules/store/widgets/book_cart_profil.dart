import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BookCardProfRedares extends StatelessWidget {
  final String title;
  final String author;
  final String description;
  final String imageUrl;
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;

  const BookCardProfRedares({
    Key? key,
    required this.title,
    required this.author,
    required this.description,
    required this.imageUrl,
    required this.buttonText,
    required this.buttonColor,
    this.buttonTextColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
       
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book Cover
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageUrl,
                  width: 70,
                  height: 106,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 16),

              // Book Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                         fontFamily: StringConstants.SFPro,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      author,
                      style: TextStyle(fontSize: 14, 
                       fontFamily: StringConstants.SFPro,
                      color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: buttonTextColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side:
                        buttonColor == Colors.grey[200]
                            ? BorderSide.none
                            : BorderSide.none,
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 14,
                     fontFamily: StringConstants.SFPro,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Quote icon and description
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/ic1.png',

                width: 16,
                height: 16,
                color: AppColors.mainColor,
              ),

              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                     fontFamily: StringConstants.NewYork,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(height: 32, color: Colors.grey[300]),
        ],
      ),
    );
  }
}
