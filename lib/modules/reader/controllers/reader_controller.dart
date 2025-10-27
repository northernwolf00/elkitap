import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class ReaderController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxBool showControls = false.obs;
  final RxBool showSettings = false.obs;
  final Rx<Color> backgroundColor = const Color(0xFFFFFFFF).obs;
  final Rx<Color> textColor = const Color(0xFF000000).obs;
  final RxDouble fontSize = 16.0.obs;
  final RxString selectedTheme = 'Bold'.obs;
  final RxInt currentPage = 112.obs;
  final RxInt totalPages = 112.obs;
  final RxString bookPath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadBook();
  }

  void loadBook() async {
    try {
      // Load EPUB from assets
      await Future.delayed(const Duration(seconds: 2));

      // Copy EPUB from assets to local storage
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/book.epub');

      if (!await file.exists()) {
        final data = await rootBundle.load('assets/books/7.epub');
        final bytes = data.buffer.asUint8List();
        await file.writeAsBytes(bytes);
      }

      bookPath.value = file.path;
      isLoading.value = false;
    } catch (e) {
      print('Error loading book: $e');
      // If asset not found, still show reader for demo
      await Future.delayed(const Duration(seconds: 1));
      isLoading.value = false;
    }
  }

  void openEpubBook() {
    if (bookPath.value.isNotEmpty) {
      VocsyEpub.setConfig(
        themeColor: backgroundColor.value,
        identifier: "iosBook",
        scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
        allowSharing: true,
        enableTts: true,
        nightMode: selectedTheme.value == 'Quite',
      );

      VocsyEpub.open(
        bookPath.value,
        lastLocation: EpubLocator.fromJson({
          "bookId": "book",
          "href": "/chapter1.html",
          "created": 1539934158390,
          "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
        }),
      );
    }
  }

  final List<ThemeOption> themes = [
    ThemeOption('Bold', Color(0xFFFFFFFF), Color(0xFF000000)),
    ThemeOption('Quite', Color(0xFF2C2C2E), Color(0xFFE5E5E5)),
    ThemeOption('Paper', Color(0xFFF5F1E8), Color(0xFF3C3C3C)),
    ThemeOption('Bold', Color(0xFFFFFFFF), Color(0xFF000000)),
    ThemeOption('Calm', Color(0xFFF5E6D3), Color(0xFF4A4A4A)),
    ThemeOption('Focus', Color(0xFFE8E8E8), Color(0xFF1C1C1E)),
  ];

  void toggleControls() {
    showControls.value = !showControls.value;
    if (showControls.value) {
      showSettings.value = false;
    }
  }

  void toggleSettings() {
    showSettings.value = !showSettings.value;
  }

  void selectTheme(String theme) {
    selectedTheme.value = theme;
    final selected = themes.firstWhere((t) => t.name == theme);
    backgroundColor.value = selected.backgroundColor;
    textColor.value = selected.textColor;
  }

  void increaseFontSize() {
    if (fontSize.value < 28) {
      fontSize.value += 2;
    }
  }

  void decreaseFontSize() {
    if (fontSize.value > 12) {
      fontSize.value -= 2;
    }
  }
}

class ThemeOption {
  final String name;
  final Color backgroundColor;
  final Color textColor;

  ThemeOption(this.name, this.backgroundColor, this.textColor);
}
