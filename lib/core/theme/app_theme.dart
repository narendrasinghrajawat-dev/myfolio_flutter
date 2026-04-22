import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_theme_colors.dart';
import '../constants/app_sizes.dart';

class AppTheme {
  // Light ThemeData with environment-based colors
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppThemeColors.primary,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppThemeColors.lightBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: AppThemeColors.lightSurface,
      foregroundColor: AppThemeColors.lightOnSurface,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      color: AppThemeColors.lightSurface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppThemeColors.primary,
        foregroundColor: AppThemeColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingLG,
          vertical: AppSizes.paddingMD,
        ),
      ),
    ),
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        headlineLarge: TextStyle(
          fontSize: AppSizes.fontXXXL,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontSize: AppSizes.fontXXL,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          fontSize: AppSizes.fontXL,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          fontSize: AppSizes.fontLG,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          fontSize: AppSizes.fontMD,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          fontSize: AppSizes.fontSM,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  );

  // Dark ThemeData with environment-based colors
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppThemeColors.primary,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: AppThemeColors.darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: AppThemeColors.darkSurface,
      foregroundColor: AppThemeColors.darkOnSurface,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      color: AppThemeColors.darkSurface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppThemeColors.primary,
        foregroundColor: AppThemeColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingLG,
          vertical: AppSizes.paddingMD,
        ),
      ),
    ),
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        headlineLarge: TextStyle(
          fontSize: AppSizes.fontXXXL,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontSize: AppSizes.fontXXL,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          fontSize: AppSizes.fontXL,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          fontSize: AppSizes.fontLG,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          fontSize: AppSizes.fontMD,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          fontSize: AppSizes.fontSM,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  );
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
