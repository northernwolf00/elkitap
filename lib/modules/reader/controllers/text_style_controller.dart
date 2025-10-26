import 'package:get/get.dart';

class TextStyleController extends GetxController {
  final _fontSize = 16.obs;
  final _fontFamily = 'Default'.obs;
  final _lineHeight = 1.5.obs;

  // Getters
  int get fontSize => _fontSize.value;
  String get fontFamily => _fontFamily.value;
  double get lineHeight => _lineHeight.value;

  void updateFontSize(int size) {
    _fontSize.value = size;
  }

  void updateFontFamily(String family) {
    _fontFamily.value = family;
  }

  void updateLineHeight(double height) {
    _lineHeight.value = height;
  }

  void increaseFontSize() {
    if (_fontSize.value < 32) {
      _fontSize.value += 2;
    }
  }

  void decreaseFontSize() {
    if (_fontSize.value > 10) {
      _fontSize.value -= 2;
    }
  }
}
