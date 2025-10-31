import 'dart:ui';
import 'package:elkitap/core/constants/string_constants.dart';
import 'package:flutter/material.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String _selectedLang = 'English';

  final List<String> _languages = ['Türkmençe', 'Русский', 'English'];

  void _showLanguageMenu(BuildContext context) async {
    final selected = await showDialog<String>(
      context: context,
      barrierColor: Colors.transparent, // allow glass effect
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              top: 60, // 30 pixels from top
              left: 0,
              right: 0,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      width: 160,
                      color: Colors.grey[100],
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _languages.map((lang) {
                          final isSelected = lang == _selectedLang;
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context, lang);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 18),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        lang,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: StringConstants.SFPro,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      if (isSelected)
                                        const Icon(Icons.check,
                                            size: 18, color: Colors.black),
                                    ],
                                  ),
                                ),
                              ),
                              if (lang != _languages.last)
                                Divider(color: Colors.grey.withOpacity(0.3))
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
        );
      },
    );

    if (selected != null) {
      setState(() {
        _selectedLang = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showLanguageMenu(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language, size: 20),
            const SizedBox(width: 6),
            Text(
              _selectedLang,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: StringConstants.SFPro,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
