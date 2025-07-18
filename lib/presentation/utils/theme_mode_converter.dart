// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description: 
// -------------------------------------------------------------------
import 'package:flutter/material.dart';

class ThemeModeConverter {
  static ThemeMode fromInt(int value) {
    switch (value) {
      case 1:
        return ThemeMode.dark;
      case 0:
      default:
        return ThemeMode.light;
    }
  }

  static int toInt(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return 1;
      case ThemeMode.light:
      default:
        return 0;
    }
  }
}
