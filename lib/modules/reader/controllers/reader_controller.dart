import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

// Controller
class BookReaderController extends GetxController {
  var isLoading = false.obs;
  var bookTitle = 'The Truth, Instead'.obs;
  var selectedThemeIndex = 1.obs;
  var fontSize = 16.0.obs;
  var brightness = 0.5.obs;

  // Open book from assets
  void openBookFromAsset(String assetPath) async {
    isLoading.value = true;

    try {
      VocsyEpub.setConfig(
        themeColor: _getThemeColor(),
        identifier: "bookReader",
        scrollDirection: EpubScrollDirection.HORIZONTAL,
        allowSharing: true,
        enableTts: true,
        nightMode: selectedThemeIndex.value == 1,
      );

      await VocsyEpub.openAsset(
        assetPath,
        lastLocation: EpubLocator.fromJson({
          "bookId": "1",
          "href": "/chapter1.xhtml",
          "created": DateTime.now().millisecondsSinceEpoch,
          "locations": {"cfi": ""}
        }),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to open book: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Open book from URL
  void openBookFromUrl(String url) async {
    isLoading.value = true;

    try {
      VocsyEpub.setConfig(
        themeColor: _getThemeColor(),
        identifier: "bookReader",
        scrollDirection: EpubScrollDirection.HORIZONTAL,
        allowSharing: true,
        enableTts: true,
        nightMode: selectedThemeIndex.value == 1,
      );

      VocsyEpub.open(
        url,
        lastLocation: EpubLocator.fromJson({
          "bookId": "1",
          "href": "/chapter1.xhtml",
          "created": DateTime.now().millisecondsSinceEpoch,
          "locations": {"cfi": ""}
        }),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to open book: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Color _getThemeColor() {
    switch (selectedThemeIndex.value) {
      case 0:
      case 3:
        return Colors.blue;
      case 1:
        return Colors.grey[800]!;
      case 2:
        return Color(0xFFF5F1E8);
      case 4:
        return Color(0xFFE8D5C4);
      case 5:
        return Colors.blue;
      default:
        return Colors.blue;
    }
  }

  void changeTheme(int index) {
    selectedThemeIndex.value = index;
    VocsyEpub.setConfig(
      themeColor: _getThemeColor(),
      identifier: "bookReader",
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
      allowSharing: true,
      enableTts: true,
      nightMode: index == 1,
    );
  }

  void changeFontSize(double size) {
    fontSize.value = size;
  }

  void changeBrightness(double value) {
    brightness.value = value;
  }
}
