import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.neutral_01,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.neutral_01,
        secondary: AppColors.blue,
        onSecondary: AppColors.neutral_01,
        error: AppColors.red,
        onError: AppColors.neutral_01,
        surface: AppColors.neutral_02,
        onSurface: AppColors.neutral_07,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.hero,
        displayMedium: AppTextStyles.headline1,
        displaySmall: AppTextStyles.headline2,
        headlineLarge: AppTextStyles.headline3,
        headlineMedium: AppTextStyles.headline4,
        headlineSmall: AppTextStyles.headline5,
        titleLarge: AppTextStyles.headline6,
        titleMedium: AppTextStyles.headline7,
        titleSmall: AppTextStyles.body1,
        bodyLarge: AppTextStyles.body2,
        bodyMedium: AppTextStyles.caption1,
        bodySmall: AppTextStyles.caption2,
        labelLarge: AppTextStyles.buttonM,
        labelMedium: AppTextStyles.buttonS,
        labelSmall: AppTextStyles.buttonXS,
      ),
    );
  }
}
