// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------

import 'package:poyopoyo_weather/domain/repositories/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  static const String _themeKey = 'theme'; //0: light, 1: dark

  @override
  Future<void> saveThemeMode(int mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, mode);
  }

  @override
  Future<int> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_themeKey) ?? 0;
  }
}
