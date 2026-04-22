import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppThemeMode { light, dark, system }

class ThemeState {
  final AppThemeMode mode;
  final bool isDarkMode;
  
  const ThemeState({
    required this.mode,
    required this.isDarkMode,
  });
  
  ThemeState copyWith({
    AppThemeMode? mode,
    bool? isDarkMode,
  }) {
    return ThemeState(
      mode: mode ?? this.mode,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeState &&
          runtimeType == other.runtimeType &&
          mode == other.mode &&
          isDarkMode == other.isDarkMode;

  @override
  int get hashCode => Object.hash(mode, isDarkMode);
}

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(const ThemeState(
    mode: AppThemeMode.system,
    isDarkMode: false,
  )) {
    _loadTheme();
  }
  
  Future<void> _loadTheme() async {
    // TODO: Load from SharedPreferences
    final isDark = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    state = ThemeState(mode: AppThemeMode.system, isDarkMode: isDark);
  }
  
  Future<void> setTheme(AppThemeMode mode) async {
    bool isDark = false;
    switch (mode) {
      case AppThemeMode.light:
        isDark = false;
        break;
      case AppThemeMode.dark:
        isDark = true;
        break;
      case AppThemeMode.system:
        isDark = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
        break;
    }
    
    state = ThemeState(mode: mode, isDarkMode: isDark);
    // TODO: Save to SharedPreferences
  }
  
  Future<void> toggleTheme() async {
    final newMode = state.isDarkMode ? AppThemeMode.light : AppThemeMode.dark;
    await setTheme(newMode);
  }
}

// Providers
final themeStateProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});

final isDarkModeProvider = Provider<bool>((ref) {
  return ref.watch(themeStateProvider).isDarkMode;
});

final themeModeProvider = Provider<AppThemeMode>((ref) {
  return ref.watch(themeStateProvider).mode;
});
