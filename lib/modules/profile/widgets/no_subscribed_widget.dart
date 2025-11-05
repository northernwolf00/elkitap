import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
         "not_subscribed_t".tr,
          style: const TextStyle(
             fontFamily: StringConstants.SFPro,
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
            child: Text("subscribe".tr,
                style: TextStyle(fontSize: 14,
                 fontFamily: StringConstants.SFPro,
                 color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
