import 'package:elkitap/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NotSubscribedView extends StatelessWidget {
  final VoidCallback onSubscribe;

  const NotSubscribedView({super.key, required this.onSubscribe});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        Text(
          "Not subscribed",
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        Container(height: 1, color: Colors.grey[300]),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 34,
          child: ElevatedButton(
            onPressed: onSubscribe,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.bgItemProColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: const Text("Subscribe",
                style: TextStyle(fontSize: 14, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
