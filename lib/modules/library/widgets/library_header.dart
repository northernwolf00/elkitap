import 'package:elkitap/global_widgets/custom_icon.dart';
import 'package:elkitap/modules/profile/views/profile_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LibraryHeader extends StatelessWidget {
  const LibraryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "My Library",
          style: TextStyle(
            fontFamily: 'New York',
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () {
            Get.to(() => ProfileScreen());
          },
          icon: CustomIcon(
            title: 'assets/icons/i1.svg',
            height: 40,
            width: 40,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
