import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.accent,
    ),
    textTheme: const TextTheme(
      titleLarge: AppTextStyles.headline, // was headline6
      bodyMedium: AppTextStyles.body,     // was bodyText2
      bodySmall: AppTextStyles.caption,   // was caption
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
  );

  static final ThemeData dark = ThemeData.dark().copyWith(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.black,
  );
}
