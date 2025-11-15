import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/data/network/token_managet.dart';
import 'package:elkitap/global_widgets/custom_icon.dart';
import 'package:elkitap/modules/auth/views/login_view.dart';
import 'package:elkitap/modules/profile/views/profile_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LibraryHeader extends StatelessWidget {
  const LibraryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // Get TokenManager instance
    final TokenManager tokenManager = Get.find<TokenManager>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'myLibrary'.tr,
          style: const TextStyle(
            fontFamily: StringConstants.NewYork,
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        IconButton(
          onPressed: () {
            // Check if user is authenticated
            if (tokenManager.isAuthenticated.value) {
              // Navigate to Profile Screen
              Get.to(() => const ProfileScreen());
            } else {
              // Navigate to Auth/Login Screen
              Get.to(() => const AuthViewScreen());
            }
          },
          icon: CustomIcon(
            title: 'assets/icons/i1.svg',
            height: 40,
            width: 40,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ],
    );
  }
}