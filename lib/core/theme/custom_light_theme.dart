import 'package:elkitap/core/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';


final class CustomLightTheme {
  ThemeData get themeData => ThemeData(
        useMaterial3: true,
        fontFamily: 'PlusJakartaSans',
        appBarTheme: AppBarTheme(),
        colorScheme: CustomColorScheme.lightColorScheme,
      );
}
