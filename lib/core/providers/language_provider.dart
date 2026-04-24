import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum AppLanguage { english, hindi }

class LanguageNotifier extends StateNotifier<Locale> {
  LanguageNotifier() : super(const Locale('en'));

  void setLanguage(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        state = const Locale('en');
        break;
      case AppLanguage.hindi:
        state = const Locale('hi');
        break;
    }
  }

  AppLanguage getCurrentLanguage() {
    if (state.languageCode == 'hi') {
      return AppLanguage.hindi;
    }
    return AppLanguage.english;
  }
}

final languageProvider = StateNotifierProvider<LanguageNotifier, Locale>((ref) {
  return LanguageNotifier();
});
