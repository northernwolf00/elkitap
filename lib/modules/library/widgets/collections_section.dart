import 'package:elkitap/global_widgets/custom_icon.dart';
import 'package:elkitap/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionsSection extends StatelessWidget {
  const CollectionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final collections = [
      {"icon": 'assets/icons/m1.svg', "title": "Want to Read", "count": 5},
      {"icon": 'assets/icons/m2.svg', "title": "Want to Listen", "count": 5},
      {"icon": 'assets/icons/m3.svg', "title": "Notes", "count": 2},
      {"icon": 'assets/icons/m4.svg', "title": "Finished", "count": 1},
      {"icon": 'assets/icons/m5.svg', "title": "Downloaded", "count": 2},
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Collections",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),
          Container(height: 1, color: Colors.grey[200]),
          ...collections.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CustomIcon(
                    title: item["icon"].toString(),
                    height: 24,
                    width: 24,
                    color: Colors.black,
                  ),
                  title: Text(
                    item["title"] as String,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item["count"].toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 22,
                        color: Colors.grey[200],
                      ),
                    ],
                  ),
                  onTap: () {
                    if (index == 2) {
                      Get.toNamed(Routes.NOTES);
                    } else {
                      Get.toNamed(Routes.WANTREAD);
                    }
                  },
                ),
                // Only show divider if not the last item
                if (index != collections.length - 1)
                  Container(height: 1, color: Colors.grey[200]),
              ],
            );
          }),
        ],
      ),
    );
  }
}
