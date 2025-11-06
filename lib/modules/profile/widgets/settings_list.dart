import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/core/init/theme_controller.dart';
import 'package:elkitap/core/init/translation_service.dart';
import 'package:elkitap/global_widgets/bottom_nav_bar.dart';
import 'package:elkitap/global_widgets/custom_bottom_sheet.dart';
import 'package:elkitap/global_widgets/custom_icon.dart';
import 'package:elkitap/modules/auth/controllers/login_controller.dart';
import 'package:elkitap/modules/profile/widgets/help_and_support_sheet.dart';
import 'package:elkitap/modules/profile/widgets/model/menu_item.dart';
import 'package:elkitap/modules/paymant/widget/paymant_bottom_sheet.dart';
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
  String selectedLanguage = 'Turkmen';
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
      selectedTheme = 'dark'.tr;
    } else {
      selectedTheme = 'match_devices'.tr;
    }
  }

  @override
  Widget build(BuildContext context) {

   
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                // 1. Payment History
                _buildSettingsItem(
                  context,
                  index: 0,
                  title: 'paymentHistory'.tr,
                  trailingText: null,
                  onTapDown: (details) => _showPaymantHistorySheet(context),
                  isLast: false,
                ),

                // 2. Theme
                _buildSettingsItem(
                  context,
                  index: 1,
                  title: 'theme'.tr,
                  trailingText: selectedTheme,
                  onTapDown: (details) =>
                      _showThemeMenu(context, details.globalPosition),
                  isLast: false,
                ),

                // 3. Language
                _buildSettingsItem(
                  context,
                  index: 2,
                  title: 'language'.tr,
                  trailingText: selectedLanguage,
                  onTapDown: (details) =>
                      _showLanguageMenu(context, details.globalPosition),
                  isLast: false,
                ),

                // 4. Help and Support
                _buildSettingsItem(
                  context,
                  index: 3,
                  title: 'help_and_support'.tr,
                  trailingText: null,
                  onTapDown: (details) => _showHelpBottomSheet(context),
                  isLast: false,
                ),

                // 5. Legal Terms of Use
                _buildSettingsItem(
                  context,
                  index: 4,
                  title: 'legal_terms_of_use'.tr,
                  trailingText: null,
                  // Assuming this leads to the same bottom sheet as privacy policy in your original logic
                  onTapDown: (details) => _showLegalTermsBottomSheet(context),
                  isLast: false,
                ),

                // 6. Privacy and Policy
                _buildSettingsItem(
                  context,
                  index: 5,
                  title: 'privacy_and_policy'.tr,
                  trailingText: null,
                  // Assuming this leads to the same bottom sheet as legal terms in your original logic
                  onTapDown: (details) => _showLegalTermsBottomSheet(context),
                  isLast: false,
                ),

       
                _buildSettingsItem(
                  context,
                  index: 6,
                  title: 'sign_out'.tr,
                  trailingText: null,
                  onTapDown: (details) => _showLogoutDialog(context),
                  isLast: true, 
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required int index,
    required String title,
    required String? trailingText,
    required Function(TapDownDetails) onTapDown,
    required bool isLast,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTapDown: onTapDown,
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

        isLast
            ? const SizedBox.shrink()
            : Container(height: 1, color: Colors.grey[200]),
      ],
    );
  }

  void _showThemeMenu(BuildContext context, Offset position) async {
    final items = [
      MenuItem(
          title: 'light'.tr, value: 'Light', icon: Icons.wb_sunny_outlined),
      MenuItem(title: 'dark'.tr, value: 'Dark', icon: Icons.nightlight_round),
      MenuItem(
          title: 'match_devices'.tr, value: 'System', icon: Icons.contrast),
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
        selectedTheme = result == 'Light' ? 'light'.tr : result == 'Dark' ? 'dark'.tr : 'match_devices'.tr  ;
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
          title: Text(
            'do_you_really_want_to_log_out'.tr,
            style: TextStyle(
              fontFamily: StringConstants.SFPro,
              fontWeight: FontWeight.bold, // Make title bold
              fontSize: 17, // Adjust font size as needed
            ),
          ),
          content: Text(
            'log_out_warning'.tr,
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
              child: Text(
                'no'.tr,
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
              child: Text(
                'yes'.tr,
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
