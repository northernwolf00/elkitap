import 'package:elkitap/modules/profile/widgets/no_subscribed_widget.dart';
import 'package:elkitap/modules/profile/widgets/subscribed_widget.dart';
import 'package:flutter/material.dart';

class ProfileCardUser extends StatelessWidget {
  final bool isSubscribed;
  final int daysLeft;
  final VoidCallback onSubscribe;

  const ProfileCardUser({
    super.key,
    required this.isSubscribed,
    required this.daysLeft,
    required this.onSubscribe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Murat Sapayev",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "+993 61626406",
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              TextButton(onPressed: () {}, child: const Text("Edit account")),
            ],
          ),
          const SizedBox(height: 12),
          !isSubscribed
              ? NotSubscribedView(onSubscribe: onSubscribe)
              : SubscribedView(daysLeft: daysLeft),
        ],
      ),
    );
  }
}
