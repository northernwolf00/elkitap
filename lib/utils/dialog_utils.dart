import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/global_widgets/custom_icon.dart';
import 'package:elkitap/modules/store/controllers/store_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'dart:ui';

class DialogUtils {
  // Show options popup menu
  static void showOptionsPopupMenu(
      BuildContext context, BookDetailController controller) {
    showDialog(
      context: context,
      barrierColor: Colors.black26,
      builder: (context) => Stack(
        children: [
          // Positioned popup menu
          Positioned(
            top: 60,
            right: 16,
            child: Material(
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black.withOpacity(0.75)
                          : Colors.white.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black.withOpacity(0.3)
                            : Colors.white.withOpacity(0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildMenuOption(
                            icon: 'assets/icons/d1.svg',
                            title: 'share'.tr,
                            onTap: () {
                              Navigator.pop(context);
                              // Handle share
                            },
                            context: context),
                        Container(
                          height: 6,
                          color: Colors.grey[400],
                        ),
                        Obx(() => _buildMenuOption(
                            icon: controller.isAddedToWantToRead.value
                                ? 'assets/icons/d5.svg'
                                : 'assets/icons/d2.svg',
                            title: 'add_to_want_to_read'.tr,
                            onTap: () {
                              Navigator.pop(context);
                              controller.toggleAddToWantToRead();
                              showAddedDialog(context,
                                  controller.isAddedToWantToRead.value);
                            },
                            context: context)),
                        Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                        _buildMenuOption(
                            icon: 'assets/icons/d3.svg',
                            title: 'add_to_collection'.tr,
                            onTap: () {
                              Navigator.pop(context);
                              // Handle add to collection
                            },
                            context: context),
                        Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                        _buildMenuOption(
                            icon: 'assets/icons/d5.svg',
                            title: 'mark_as_finished'.tr,
                            onTap: () {
                              Navigator.pop(context);
                              // Handle mark as finished
                            },
                            context: context),
                        Container(
                          height: 6,
                          color: Colors.grey[400],
                        ),
                        _buildMenuOption(
                            icon: 'assets/icons/d6.svg',
                            title: 'remove'.tr,
                            titleColor: const Color(0xFFFF5A3C),
                            iconColor: const Color(0xFFFF5A3C),
                            onTap: () {
                              Navigator.pop(context);
                              // Handle remove
                            },
                            context: context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void showAudioPopupMenu(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      barrierColor: Colors.black26,
      builder: (context) => Stack(
        children: [
          // Positioned popup menu
          Positioned(
            top: 60,
            right: 16,
            child: Material(
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black.withOpacity(0.75)
                          : Color(0xFF3D3633).withOpacity(0.95),
                      borderRadius: BorderRadius.circular(16),
                      // border: Border.all(
                      //   color: Theme.of(context).brightness == Brightness.dark
                      //       ? Colors.black.withOpacity(0.3)
                      //       : Colors.white.withOpacity(0.3),
                      //   width: 1.5,
                      // ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildMenuOption(
                            icon: 'assets/icons/m1.svg',
                            title: 'switch_to_book'.tr,
                            titleColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            onTap: () {
                              Navigator.pop(context);
                              // Handle share
                            },
                            context: context),
                        Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                        _buildMenuOption(
                            icon: 'assets/icons/d11.svg',
                            title: 'book_description'.tr,
                            titleColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            onTap: () {
                              Navigator.pop(context);
                            },
                            context: context),
                        Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                        _buildMenuOption(
                            icon: 'assets/icons/a10.svg',
                            title: 'download'.tr,
                            titleColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            onTap: () {
                              Navigator.pop(context);
                              // Handle add to collection
                            },
                            context: context),
                        Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                        _buildMenuOption(
                            icon: 'assets/icons/d11.svg',
                            title: 'transcript_view'.tr,
                            titleColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            onTap: () {
                              Navigator.pop(context);
                              // Handle mark as finished
                            },
                            context: context),
                        Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                        _buildMenuOption(
                            icon: 'assets/icons/a11.svg',
                            title: 'add_to_want_to_listen'.tr,
                            titleColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            onTap: () {
                              Navigator.pop(context);
                              // Handle mark as finished
                            },
                            context: context),
                        Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                        _buildMenuOption(
                            icon: 'assets/icons/d1.svg',
                            title: 'share'.tr,
                            titleColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            onTap: () {
                              Navigator.pop(context);
                              // Handle mark as finished
                            },
                            context: context),
                        Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                        _buildMenuOption(
                            icon: 'assets/icons/a12.svg',
                            title: 'report_an_issue'.tr,
                            titleColor: const Color(0xFFFF5A3C),
                            iconColor: const Color(0xFFFF5A3C),
                            onTap: () {
                              Navigator.pop(context);
                              // Handle remove
                            },
                            context: context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void showAddedDialog(BuildContext context, bool isAdded) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: isAdded ? const Color(0xFFFF5A3C) : Colors.black87,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isAdded ? Icons.check : Icons.close,
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                isAdded ? 'added'.tr : 'removed'.tr,
                style: const TextStyle(
                  fontSize: 28,
                  fontFamily: StringConstants.SFPro,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                isAdded
                    ? 'book_added_to_want_to_read_list'.tr
                    : 'book_removed_from_want_to_read_list'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: StringConstants.SFPro,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showLanguagePopup(
      BuildContext context, BookDetailController controller) {
    final languages = ['Türkmençe', 'Русский', 'English'];

    showDialog(
      context: context,
      barrierColor: Colors.black26,
      builder: (context) => Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 40,
            left: 110,

            // bottom: 60,

            child: Material(
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black.withOpacity(0.85)
                          : Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black.withOpacity(
                                0.3) // Dark Mode: Use highly opaque white
                            : Colors.white.withOpacity(0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: languages.map((language) {
                        final isLast = language == languages.last;
                        return Column(
                          children: [
                            Obx(() => InkWell(
                                  onTap: () {
                                    controller.setLanguage(language);
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 16,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            language,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontFamily: StringConstants.SFPro,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        if (controller.selectedLanguage.value ==
                                            language)
                                          const Icon(
                                            Icons.check,
                                            size: 24,
                                          ),
                                      ],
                                    ),
                                  ),
                                )),
                            if (!isLast)
                              Divider(
                                height: 1,
                                color: Colors.grey.withOpacity(0.2),
                              ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildMenuOption({
    required String icon,
    required String title,
    required VoidCallback onTap,
    required BuildContext context,
    Color? titleColor,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  color: titleColor,
                  fontFamily: StringConstants.SFPro,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            CustomIcon(
              title: icon,
              height: 24,
              width: 24,
              color: iconColor ??
                  (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black),
            )
          ],
        ),
      ),
    );
  }

  static void showBookDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Header with book cover and title
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Book cover
                    Container(
                        width: 70,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF5A3C),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          'assets/images/b4.png',
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(width: 16),
                    // Title and author
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'subtle_art_of_not_giving_a_f*ck'.tr,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontFamily: StringConstants.SFPro,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'mark_manson'.tr,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: StringConstants.SFPro,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Close button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1.5,
              ),
              // Scrollable content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  children: [
                    // About section
                    Text(
                      'about'.tr,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: StringConstants.SFPro,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'book_description_text'.tr,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                        fontFamily: StringConstants.SFPro,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Basic Info section
                    Text(
                      'basic_info'.tr,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: StringConstants.SFPro,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('author'.tr, 'mark_manson'.tr),
                    _buildInfoRow('language'.tr, 'english'.tr),
                    _buildInfoRow('genre'.tr, 'health_mind_body'.tr),
                    _buildInfoRow('age'.tr, 'age_18_plus'.tr),
                    _buildInfoRow('publication_date'.tr, '28.10.2024',
                        isLast: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildInfoRow(String label, String value,
      {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 140,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: StringConstants.SFPro,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringConstants.SFPro,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
      ],
    );
  }

  static void showIOSStylePopup(BuildContext context, Function onShare,
      Function onAddToCollection, Function onMarkFinished, Function onRemove) {
    showDialog(
      context: context,
      barrierColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white24 // light semi-transparent overlay in dark mode
          : Colors.black26,
      builder: (context) => Stack(
        children: [
          Positioned(
            top: 120,
            right: 40,
            child: Material(
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black.withOpacity(0.75)
                          : Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black.withOpacity(0.3)
                            : Colors.white.withOpacity(0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildIOSMenuOption(
                          context,
                          iconPath: 'assets/icons/d11.svg',
                          title: 'open_book'.tr,
                          onTap: () => onShare(),
                        ),
                        Container(
                          height: 6,
                          color: Colors.grey[400],
                        ),
                        _buildIOSMenuOption(
                          context,
                          iconPath: 'assets/icons/d1.svg',
                          title: 'share'.tr,
                          onTap: () => onAddToCollection(),
                        ),
                        Divider(
                          height: 1,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white.withOpacity(
                                  0.1) // subtle divider in dark mode
                              : Colors.grey.withOpacity(
                                  0.2), // light divider in light mode
                        ),
                        _buildIOSMenuOption(
                          context,
                          iconPath: 'assets/icons/d10.svg',
                          title: 'edit'.tr,
                          onTap: () => onMarkFinished(),
                        ),
                        Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                        _buildIOSMenuOption(
                          context,
                          iconPath: 'assets/icons/d6.svg',
                          title: 'delete'.tr,
                          iconColor: const Color(0xFFFF5A3C),
                          titleColor: const Color(0xFFFF5A3C),
                          onTap: () => onRemove(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildIOSMenuOption(
    BuildContext context, {
    required String iconPath,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? titleColor,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  color: titleColor ??
                      (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white // white in dark mode
                          : Colors.black)),
            ),
            Spacer(),
            SvgPicture.asset(iconPath,
                width: 20,
                height: 20,
                color: iconColor ??
                    (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // white in dark mode
                        : Colors.black)),
          ],
        ),
      ),
    );
  }
}
