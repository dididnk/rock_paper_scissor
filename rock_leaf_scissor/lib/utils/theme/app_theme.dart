import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  // === Light Theme ===
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      background: backgroundColorLight,
      onBackground: onBackgroundLight,
      onPrimary: onPrimaryColorLight,
    ),
    scaffoldBackgroundColor: backgroundColorLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: onPrimaryColorLight,
    ),
  );

  // === Dark Theme ===
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      background: backgroundColorDark,
      onBackground: onBackgroundDark,
      onPrimary: onPrimaryColorDark,
    ),
    scaffoldBackgroundColor: backgroundColorDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: onPrimaryColorDark,
    ),
  );
}
