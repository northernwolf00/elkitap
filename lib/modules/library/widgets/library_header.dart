import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/global_widgets/custom_icon.dart';
import 'package:elkitap/modules/auth/controllers/login_controller.dart';
import 'package:elkitap/modules/auth/views/login_view.dart';
import 'package:elkitap/modules/profile/views/profile_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LibraryHeader extends StatelessWidget {
  const LibraryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "My Library",
          style: TextStyle(
            fontFamily: StringConstants.NewYork,
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () {
            if (authController.isAuthenticated.value) {
              Get.to(() => const ProfileScreen());
            } else {
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
