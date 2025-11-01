import 'package:elkitap/core/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Center title
  final String? leadingText; // Text next to back icon
  final Color backgroundColor;
  final Color textColor;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leadingText,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false, // We’ll build our own leading row
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 👈 Back + Leading Text
          showBackButton
              ? Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Get.back(),
                    ),
                    if (leadingText != null)
                      Text(
                        leadingText!,
                        style: TextStyle(
                          fontSize: 17,
                          
                           fontFamily: StringConstants.SFPro,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                )
              : SizedBox(),

          // 🧭 Center Title
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                   fontFamily: StringConstants.SFPro,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Placeholder for alignment (so center stays centered)
          const SizedBox(width: 80),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
