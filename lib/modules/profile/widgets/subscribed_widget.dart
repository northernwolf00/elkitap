import 'package:elkitap/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SubscribedView extends StatelessWidget {
  final int daysLeft;

  const SubscribedView({super.key, required this.daysLeft});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Subscription ends in $daysLeft days",
              style: const TextStyle(color: Colors.black54),
            ),
            Image.asset('assets/images/subscribed.png',
            height: 46,
            width: 46,)
          ],
        ),
        
        const SizedBox(height: 12),
        Container(height: 1, color: Colors.grey[300]),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bgItemProColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  
                ),
                child: const Text("Extend", style: TextStyle(fontSize: 14,
            color: Colors.white)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonGreyColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  
                ),
                child: const Text("Promocode", style: TextStyle(fontSize: 14,
            color: Colors.black)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
