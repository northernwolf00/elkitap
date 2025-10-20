import 'package:elkitap/core/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';


final class CustomDarkTheme {
  final ThemeData themeData = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(),
    fontFamily: 'PlusJakartaSans',
    colorScheme: CustomColorScheme.darkColorScheme,
  );
}
