import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/core/theme/app_colors.dart';
import 'package:elkitap/modules/profile/widgets/subscription_expired_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscribedView extends StatelessWidget {
  final int daysLeft;

  const SubscribedView({super.key, required this.daysLeft});

  @override
  Widget build(BuildContext context) {
    void _showSubscriptionExpiredSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => const SubscriptionExpiredSheet(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Subscription ends in 30 days",
              style: const TextStyle(fontSize: 14),
            ),
            Image.asset(
              'assets/images/subscribed.png',
              height: 46,
              width: 46,
            )
          ],
        ),
        const SizedBox(height: 12),
        Container(height: 1, color: Colors.grey[300]),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _showSubscriptionExpiredSheet(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bgItemProColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: Text("extend".tr,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: StringConstants.SFPro,
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
                child: Text("promocode".tr,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: StringConstants.SFPro,
                        color: Colors.black)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
