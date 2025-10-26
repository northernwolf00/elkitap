import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum BgColors { white, sepia, dark, black, custom }

class BgColorState {
  final Color bgColor;
  final Color textColor;
  final Color sliderColor;
  final Color sliderBgColor;
  final Color pageNumberColor;
  final Color bottomSheetColor;
  final String bgColorHex;
  final String fgColorHex;
  final BgColors colorType;

  BgColorState({
    required this.bgColor,
    required this.textColor,
    required this.sliderColor,
    required this.sliderBgColor,
    required this.pageNumberColor,
    required this.bottomSheetColor,
    required this.bgColorHex,
    required this.fgColorHex,
    required this.colorType,
  });

  factory BgColorState.white() {
    return BgColorState(
      bgColor: Colors.white,
      textColor: Colors.black,
      sliderColor: Colors.blue,
      sliderBgColor: Colors.grey[300]!,
      pageNumberColor: Colors.black87,
      bottomSheetColor: Colors.white,
      bgColorHex: '#FFFFFF',
      fgColorHex: '#000000',
      colorType: BgColors.white,
    );
  }

  factory BgColorState.sepia() {
    return BgColorState(
      bgColor: const Color(0xFFF4ECD8),
      textColor: const Color(0xFF5C4A3A),
      sliderColor: const Color(0xFF8B7355),
      sliderBgColor: const Color(0xFFE8DCC4),
      pageNumberColor: const Color(0xFF5C4A3A),
      bottomSheetColor: const Color(0xFFF4ECD8),
      bgColorHex: '#F4ECD8',
      fgColorHex: '#5C4A3A',
      colorType: BgColors.sepia,
    );
  }

  factory BgColorState.dark() {
    return BgColorState(
      bgColor: const Color(0xFF1E1E1E),
      textColor: const Color(0xFFE0E0E0),
      sliderColor: const Color(0xFF4A9EFF),
      sliderBgColor: const Color(0xFF3A3A3A),
      pageNumberColor: const Color(0xFFB0B0B0),
      bottomSheetColor: const Color(0xFF2D2D2D),
      bgColorHex: '#1E1E1E',
      fgColorHex: '#E0E0E0',
      colorType: BgColors.dark,
    );
  }

  factory BgColorState.black() {
    return BgColorState(
      bgColor: Colors.black,
      textColor: Colors.white,
      sliderColor: Colors.white70,
      sliderBgColor: Colors.grey[800]!,
      pageNumberColor: Colors.white70,
      bottomSheetColor: const Color(0xFF121212),
      bgColorHex: '#000000',
      fgColorHex: '#FFFFFF',
      colorType: BgColors.black,
    );
  }
}

class BgColorController extends GetxController {
  final Rx<BgColorState> _state = BgColorState.white().obs;

  BgColorState get state => _state.value;

  void updateColor(BgColors colorType) {
    switch (colorType) {
      case BgColors.white:
        _state.value = BgColorState.white();
        break;
      case BgColors.sepia:
        _state.value = BgColorState.sepia();
        break;
      case BgColors.dark:
        _state.value = BgColorState.dark();
        break;
      case BgColors.black:
        _state.value = BgColorState.black();
        break;
      case BgColors.custom:
        break;
    }
  }
}
