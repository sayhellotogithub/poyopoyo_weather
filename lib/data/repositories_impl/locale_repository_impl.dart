// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------

import 'dart:ui';

import 'package:poyopoyo_weather/domain/repositories/locale_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  final _localeKey = "locale";

  LocaleRepositoryImpl();

  @override
  Future<void> saveLocale(Locale locale) async {
    // SharedPreferencesを使用してロケールを保存する処理
    // ここでは例として、ロケールの言語コードを保存します
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }

  @override
  Future<Locale> getLocale() async {
    // SharedPreferencesからロケールを読み込む処理
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_localeKey) ?? 'ja';
    return Locale(languageCode);
  }
}
