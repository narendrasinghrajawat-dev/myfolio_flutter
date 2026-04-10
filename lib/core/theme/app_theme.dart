import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';

class AppTheme {
  // Light ThemeData
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightSurface,
      foregroundColor: AppColors.lightOnSurface,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      color: AppColors.lightSurface,
      shadowColor: AppColors.lightCardShadow,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spacingLarge,
          vertical: AppSizes.spacingMedium,
        ),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: AppSizes.fontSizeHeadline1,
        fontWeight: FontWeight.bold,
        fontFamily: AppTheme.fontInter,
      ),
      headlineMedium: TextStyle(
        fontSize: AppSizes.fontSizeHeadline2,
        fontWeight: FontWeight.bold,
        fontFamily: AppTheme.fontInter,
      ),
      headlineSmall: TextStyle(
        fontSize: AppSizes.fontSizeHeadline3,
        fontWeight: FontWeight.w600,
        fontFamily: AppTheme.fontInter,
      ),
      bodyLarge: TextStyle(
        fontSize: AppSizes.fontSizeLarge,
        fontWeight: FontWeight.normal,
        fontFamily: AppTheme.fontInter,
      ),
      bodyMedium: TextStyle(
        fontSize: AppSizes.fontSizeMedium,
        fontWeight: FontWeight.normal,
        fontFamily: AppTheme.fontInter,
      ),
      bodySmall: TextStyle(
        fontSize: AppSizes.fontSizeSmall,
        fontWeight: FontWeight.normal,
        fontFamily: AppTheme.fontInter,
      ),
    ),
  );

  // Dark ThemeData
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.darkOnSurface,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      color: AppColors.darkSurface,
      shadowColor: AppColors.darkCardShadow,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spacingLarge,
          vertical: AppSizes.spacingMedium,
        ),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: AppSizes.fontSizeHeadline1,
        fontWeight: FontWeight.bold,
        fontFamily: AppTheme.fontInter,
      ),
      headlineMedium: TextStyle(
        fontSize: AppSizes.fontSizeHeadline2,
        fontWeight: FontWeight.bold,
        fontFamily: AppTheme.fontInter,
      ),
      headlineSmall: TextStyle(
        fontSize: AppSizes.fontSizeHeadline3,
        fontWeight: FontWeight.w600,
        fontFamily: AppTheme.fontInter,
      ),
      bodyLarge: TextStyle(
        fontSize: AppSizes.fontSizeLarge,
        fontWeight: FontWeight.normal,
        fontFamily: AppTheme.fontInter,
      ),
      bodyMedium: TextStyle(
        fontSize: AppSizes.fontSizeMedium,
        fontWeight: FontWeight.normal,
        fontFamily: AppTheme.fontInter,
      ),
      bodySmall: TextStyle(
        fontSize: AppSizes.fontSizeSmall,
        fontWeight: FontWeight.normal,
        fontFamily: AppTheme.fontInter,
      ),
    ),
  );

  // Font family name used throughout the app
  static const String fontInter = 'Inter';
}

// Riverpod provider for theme mode management
enum AppThemeMode { light, dark, system }

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, AppThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<AppThemeMode> {
  ThemeModeNotifier() : super(AppThemeMode.system);

  void setLight() => state = AppThemeMode.light;
  void setDark() => state = AppThemeMode.dark;
  void setSystem() => state = AppThemeMode.system;
}
