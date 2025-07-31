// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poyopoyo_weather/presentation/utils/theme_mode_converter.dart';

import '../providers/locale_provider.dart';
import '../providers/theme_providers.dart';

final settingsViewModelProvider = Provider((ref) {
  return SettingsViewModel(ref);
});

class SettingsViewModel {
  final Ref ref;

  SettingsViewModel(this.ref);

  Future<void> loadInitialSettings() async {
    final themeRepo = ref.read(themePrefsProvider);
    final localeRepo = ref.read(localePrefsProvider);

    final themeInt = await themeRepo.getThemeMode();
    final locale = await localeRepo.getLocale();

    ref.read(themeModeProvider.notifier).state = ThemeModeConverter.fromInt(
      themeInt,
    );
    ref.read(localeProvider.notifier).state = locale;
  }

  Future<void> changeTheme(ThemeMode mode) async {
    ref.read(themeModeProvider.notifier).state = mode;
    final themeRepo = ref.read(themePrefsProvider);
    await themeRepo.saveThemeMode(ThemeModeConverter.toInt(mode));
  }

  Future<void> changeLocale(Locale locale) async {
    ref.read(localeProvider.notifier).state = locale;
    final localeRepo = ref.read(localePrefsProvider);
    await localeRepo.saveLocale(locale);
  }
}
