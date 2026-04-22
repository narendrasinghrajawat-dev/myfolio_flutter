import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppLanguage { en, hi }

class LocalizationState {
  final AppLanguage language;
  final Locale locale;
  
  const LocalizationState({
    required this.language,
    required this.locale,
  });
  
  LocalizationState copyWith({
    AppLanguage? language,
    Locale? locale,
  }) {
    return LocalizationState(
      language: language ?? this.language,
      locale: locale ?? this.locale,
    );
  }
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalizationState &&
          runtimeType == other.runtimeType &&
          language == other.language &&
          locale == other.locale;

  @override
  int get hashCode => Object.hash(language, locale);
}

class LocalizationNotifier extends StateNotifier<LocalizationState> {
  LocalizationNotifier() : super(const LocalizationState(
    language: AppLanguage.en,
    locale: Locale('en', 'US'),
  ));
  
  Locale _getLocaleFromLanguage(AppLanguage language) {
    switch (language) {
      case AppLanguage.en:
        return const Locale('en', 'US');
      case AppLanguage.hi:
        return const Locale('hi', 'IN');
    }
  }
  
  Future<void> setLanguage(AppLanguage language) async {
    final locale = _getLocaleFromLanguage(language);
    state = LocalizationState(language: language, locale: locale);
    // TODO: Save to SharedPreferences
  }
}

// Providers
final localizationStateProvider = StateNotifierProvider<LocalizationNotifier, LocalizationState>((ref) {
  return LocalizationNotifier();
});

final localizationNotifierProvider = localizationStateProvider.notifier;

final currentLanguageProvider = Provider<AppLanguage>((ref) {
  return ref.watch(localizationStateProvider).language;
});

final currentLocaleProvider = Provider<Locale>((ref) {
  return ref.watch(localizationStateProvider).locale;
});

// Helper function for getting localized strings
String getLocalizedString(String key, AppLanguage language) {
  switch (key) {
    case 'appName':
      switch (language) {
        case AppLanguage.en:
          return 'MyFolio';
        case AppLanguage.hi:
          return 'मेरा पोर्टफोलियो';
      }
    case 'welcomeMessage':
      switch (language) {
        case AppLanguage.en:
          return 'Welcome to MyFolio';
        case AppLanguage.hi:
          return 'मेरा पोर्टफोलियो में आपका स्वागत है';
      }
    case 'signIn':
      switch (language) {
        case AppLanguage.en:
          return 'Sign In';
        case AppLanguage.hi:
          return 'साइन इन करें';
      }
    case 'signUp':
      switch (language) {
        case AppLanguage.en:
          return 'Sign Up';
        case AppLanguage.hi:
          return 'साइन अप करें';
      }
    case 'portfolio':
      switch (language) {
        case AppLanguage.en:
          return 'Portfolio';
        case AppLanguage.hi:
          return 'पोर्टफोलियो';
      }
    case 'admin':
      switch (language) {
        case AppLanguage.en:
          return 'Admin';
        case AppLanguage.hi:
          return 'एडमिन';
      }
    case 'profile':
      switch (language) {
        case AppLanguage.en:
          return 'Profile';
        case AppLanguage.hi:
          return 'प्रोफाइल';
      }
    case 'projects':
      switch (language) {
        case AppLanguage.en:
          return 'Projects';
        case AppLanguage.hi:
          return 'प्रोजेक्ट्स';
      }
    case 'skills':
      switch (language) {
        case AppLanguage.en:
          return 'Skills';
        case AppLanguage.hi:
          return 'कौशल';
      }
    case 'about':
      switch (language) {
        case AppLanguage.en:
          return 'About';
        case AppLanguage.hi:
          return 'बारे में';
      }
    case 'contact':
      switch (language) {
        case AppLanguage.en:
          return 'Contact';
        case AppLanguage.hi:
          return 'संपर्क करें';
      }
    case 'dashboard':
      switch (language) {
        case AppLanguage.en:
          return 'Dashboard';
        case AppLanguage.hi:
          return 'डैशबोर्ड';
      }
    default:
      return key;
  }
  return key;
}

/// Extension on BuildContext for easy access to localized strings
extension LocalizationContext on BuildContext {
  String get appName => getLocalizedString('appName', AppLanguage.en);
  String get admin => getLocalizedString('admin', AppLanguage.en);
  String get dashboard => getLocalizedString('dashboard', AppLanguage.en);
  String get portfolio => getLocalizedString('portfolio', AppLanguage.en);
  String get profile => getLocalizedString('profile', AppLanguage.en);
  String get projects => getLocalizedString('projects', AppLanguage.en);
  String get skills => getLocalizedString('skills', AppLanguage.en);
  String get about => getLocalizedString('about', AppLanguage.en);
  String get contact => getLocalizedString('contact', AppLanguage.en);
  String get welcomeMessage => getLocalizedString('welcomeMessage', AppLanguage.en);
  String get signIn => getLocalizedString('signIn', AppLanguage.en);
  String get signUp => getLocalizedString('signUp', AppLanguage.en);
}
