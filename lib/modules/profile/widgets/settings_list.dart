import 'package:elkitap/global_widgets/custom_bottom_sheet.dart';
import 'package:elkitap/global_widgets/custom_icon.dart';
import 'package:elkitap/modules/profile/widgets/model/menu_item.dart';
import 'package:flutter/material.dart';


class SettingsList extends StatefulWidget {
  const SettingsList({super.key});

  @override
  State<SettingsList> createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  String selectedTheme = "Light";
  String selectedLanguage = "Türkmençe";

    void _showLegalTermsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CustomBottomSheet(),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final settings = [
    ("Payment History", null),
    ("Theme", selectedTheme),
    ("Language", selectedLanguage),
    ("Help & Support", null),
    ("Legal Terms of Use", null),
    ("Privacy and Policy", null),
    ("Sign Out", null),
  ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Settings",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
        Container(height: 1, color: Colors.grey[200]),
        Column(
          children:
              settings.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;

                final title = item.$1;

                final trailingText = title == "Theme" ? selectedTheme : item.$2;


                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        if (title == "Theme") {
                          _showThemeMenu(context, details.globalPosition);
                        } else if (title == "Language") {
                          // Get.toNamed('/legal-terms');
                           _showLanguageMenu(context, details.globalPosition);
                        }else{
                          _showLegalTermsBottomSheet(context);
                        }
                      },
                     
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CustomIcon(
                          title: 'assets/icons/p${index + 1}.svg',
                          height: 24,
                          width: 24,
                          color: Colors.black,
                        ),
                        title: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
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
      MenuItem(title: 'Light', value: 'Light', icon: Icons.wb_sunny_outlined),
      MenuItem(title: 'Dark', value: 'Dark', icon: Icons.nightlight_round),
      MenuItem(title: 'Match Devices', value: 'Match Devices', icon: Icons.contrast),
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
    }
  }

  Future<String?> showUniversalMenu({
    required BuildContext context,
    required Offset position,
    required List<MenuItem> items,
    required String selectedValue,
    bool showIcons = false,
  }) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    
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
      color: Colors.white,
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
          showIcons ?  SizedBox(
              width: 18,
              child:
                  isSelected
                      ? const Icon(Icons.check, size: 24, color: Colors.black)
                      : null,
            ) : SizedBox(),
            const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Icon or Checkmark
                if (showIcons && item.icon != null)
                  Icon(
                    item.icon,
                    size: 28,
                    color: Colors.black87,
                  )
                else if (isSelected)
                  const Icon(
                    Icons.check,
                    size: 32,
                    color: Colors.black,
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
}
