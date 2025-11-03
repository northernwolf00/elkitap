import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/core/init/theme_controller.dart';
import 'package:elkitap/core/init/translation_service.dart';
import 'package:elkitap/global_widgets/bottom_nav_bar.dart';
import 'package:elkitap/global_widgets/custom_bottom_sheet.dart';
import 'package:elkitap/global_widgets/custom_icon.dart';
import 'package:elkitap/modules/auth/controllers/login_controller.dart';
import 'package:elkitap/modules/profile/widgets/help_and_support_sheet.dart';
import 'package:elkitap/modules/profile/widgets/model/menu_item.dart';
import 'package:elkitap/modules/profile/widgets/paymant_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsList extends StatefulWidget {
  const SettingsList({super.key});

  @override
  State<SettingsList> createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  String selectedTheme = 'light'.tr;
  String selectedLanguage = "Türkmençe";
  final _box = GetStorage();
  final _languageKey = 'selectedLanguage';
  late final ThemeController _themeController;
  final AuthController authController = Get.find<AuthController>();

  void _showLegalTermsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CustomBottomSheet(),
    );
  }

  void _showHelpBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const HelpAndSupportBottomSheet(),
    );
  }

  void _showPaymantHistorySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PaymentHistoryBottomSheet(),
    );
  }

  @override
  void initState() {
    super.initState();

    _themeController = Get.find<ThemeController>();

    _initializeSelectedTheme(_themeController.themeMode);

    _loadSelectedLanguage();
  }

  void _loadSelectedLanguage() {
    final storedLanguage = _box.read(_languageKey);
    if (storedLanguage != null) {
      selectedLanguage = storedLanguage;
    } else {
      _box.write(_languageKey, selectedLanguage);
    }
  }

  void _initializeSelectedTheme(ThemeMode mode) {
    if (mode == ThemeMode.light) {
      selectedTheme = 'light'.tr;
    } else if (mode == ThemeMode.dark) {
      selectedTheme = 'Dark';
    } else {
      selectedTheme = 'Match Devices';
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = [
      ("Payment History", null),
      ('theme'.tr, selectedTheme),
      ('language'.tr, selectedLanguage),
      ("Help & Support", null),
      ('legal_terms_of_use'.tr, null),
      ('privacy_and_policy'.tr, null),
      ('sign_out'.tr, null),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'settings'.tr,
            style: TextStyle(
                fontSize: 16,
                fontFamily: StringConstants.SFPro,
                color: Colors.grey),
          ),
        ),
        Container(height: 1, color: Colors.grey[200]),
        Column(
          children: settings.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            final title = item.$1;

            final trailingText = title == 'theme'.tr ? selectedTheme : item.$2;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    if (title == 'theme'.tr) {
                      _showThemeMenu(context, details.globalPosition);
                    } else if (title == 'language'.tr) {
                      // Get.toNamed('/legal-terms');
                      _showLanguageMenu(context, details.globalPosition);
                    } else if (title == 'Sign Out') {
                      _showLogoutDialog(context);
                    } else if (title == "Help & Support") {
                      _showHelpBottomSheet(context);
                    } else if (title == 'Payment History') {
                      _showPaymantHistorySheet(context);
                    } else {
                      _showLegalTermsBottomSheet(context);
                    }
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CustomIcon(
                      title: 'assets/icons/p${index + 1}.svg',
                      height: 24,
                      width: 24,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    title: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: StringConstants.SFPro,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (trailingText != null)
                          Text(
                            trailingText,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontFamily: StringConstants.SFPro,
                            ),
                          ),
                        Icon(Icons.chevron_right, color: Colors.grey[350]),
                      ],
                    ),
                  ),
                ),
                index == 6
                    ? SizedBox()
                    : Container(height: 1, color: Colors.grey[200]),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  void _showThemeMenu(BuildContext context, Offset position) async {
    final items = [
      MenuItem(
          title: 'light'.tr, value: 'Light', icon: Icons.wb_sunny_outlined),
      MenuItem(title: 'Dark', value: 'Dark', icon: Icons.nightlight_round),
      MenuItem(title: 'Match Devices', value: 'System', icon: Icons.contrast),
    ];

    final result = await showUniversalMenu(
      context: context,
      position: position,
      items: items,
      selectedValue: selectedTheme,
      showIcons: true,
    );

    if (result != null) {
      setState(() {
        selectedTheme = result;
      });

      final themeController = Get.find<ThemeController>();

      // Use setTheme instead of changeTheme
      switch (result) {
        case 'Light':
          themeController.setTheme(ThemeMode.light);
          break;
        case 'Dark':
          themeController.setTheme(ThemeMode.dark);
          break;
        case 'System':
          themeController.setTheme(ThemeMode.system);
          break;
      }
    }
  }

  // void _showThemeMenu(BuildContext context, Offset position) async {
  //   final items = [
  //     MenuItem(title: 'Light', value: 'Light', icon: Icons.wb_sunny_outlined),
  //     MenuItem(title: 'Dark', value: 'Dark', icon: Icons.nightlight_round),
  //     MenuItem(title: 'Match Devices', value: 'Match Devices', icon: Icons.contrast),
  //   ];

  //   final result = await showUniversalMenu(
  //     context: context,
  //     position: position,
  //     items: items,
  //     selectedValue: selectedTheme,
  //     showIcons: true,
  //   );

  //   if (result != null) {
  //     setState(() {
  //       selectedTheme = result;
  //     });
  //   }
  // }

  void _showLanguageMenu(BuildContext context, Offset position) async {
    final items = [
      MenuItem(title: 'Türkmençe', value: 'Türkmençe'),
      MenuItem(title: 'Русский', value: 'Русский'),
      MenuItem(title: 'English', value: 'English'),
    ];

    final result = await showUniversalMenu(
      context: context,
      position: position,
      items: items,
      selectedValue: selectedLanguage,
      showIcons: false,
    );

    if (result != null) {
      setState(() {
        selectedLanguage = result;
      });

      final TranslationService translationService =
          Get.find<TranslationService>();
      translationService.changeLocale(result);

      _box.write(_languageKey, result);
    }
  }

  Future<String?> showUniversalMenu({
    required BuildContext context,
    required Offset position,
    required List<MenuItem> items,
    required String selectedValue,
    bool showIcons = false,
  }) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    return await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        overlay.size.width - position.dx,
        overlay.size.height - position.dy,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 8,
      constraints: const BoxConstraints(
        minWidth: 250,
        maxWidth: 350,
      ),
      items: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isSelected = selectedValue == item.value;
        final isLast = index == items.length - 1;

        return PopupMenuItem<String>(
          value: item.value,
          height: 44,
          padding: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: !isLast
                  ? const Border(
                      bottom: BorderSide(
                        color: Color(0xFFE5E5E5),
                        width: 1,
                      ),
                    )
                  : null,
            ),
            child: Row(
              children: [
                // Title
                showIcons
                    ? SizedBox(
                        width: 18,
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                size: 24,
                              )
                            : null,
                      )
                    : SizedBox(),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: StringConstants.SFPro,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Icon or Checkmark
                if (showIcons && item.icon != null)
                  Icon(
                    item.icon,
                    size: 28,
                  )
                else if (isSelected)
                  const Icon(
                    Icons.check,
                    size: 32,
                  )
                else
                  const SizedBox(width: 32),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            "Do you really want to log out?",
            style: TextStyle(
              fontFamily: StringConstants.SFPro,
              fontWeight: FontWeight.bold, // Make title bold
              fontSize: 17, // Adjust font size as needed
            ),
          ),
          content: const Text(
            "If you log out, you won't be able to read your favorite books.",
            style: TextStyle(
              fontFamily: StringConstants.SFPro,
              fontSize: 13, // Adjust font size as needed
            ),
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Add your 'No' logic here (e.g., stay logged in)
              },
              child: const Text(
                "No",
                style: TextStyle(
                  fontFamily: StringConstants.SFPro,
                  color: CupertinoColors.activeBlue, // Default blue color
                  fontWeight: FontWeight.w500, // Medium weight
                ),
              ),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
                authController.logout();
                Get.offAll(() => const BottomNavScreen());
              },
              isDestructiveAction:
                  true, // This makes the text red on iOS-style alerts
              child: const Text(
                "Yes",
                style: TextStyle(
                  fontFamily: StringConstants.SFPro,
                  // The isDestructiveAction property handles the red color
                  fontWeight: FontWeight.w500, // Medium weight
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
