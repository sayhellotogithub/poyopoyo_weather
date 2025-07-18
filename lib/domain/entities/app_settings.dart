// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------
import 'package:flutter/material.dart';

class AppSettings {
  final ThemeMode themeMode;
  final String localeCode;

  const AppSettings({required this.themeMode, required this.localeCode});

  AppSettings copyWith({ThemeMode? themeMode, String? localeCode}) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      localeCode: localeCode ?? this.localeCode,
    );
  }
}
