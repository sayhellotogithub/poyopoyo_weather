import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poyopoyo_weather/presentation/providers/locale_provider.dart';
import 'package:poyopoyo_weather/presentation/providers/theme_providers.dart';
import 'package:poyopoyo_weather/presentation/utils/theme_mode_converter.dart';

import 'app.dart';
import 'data/repositories/locale_repository_impl.dart';
import 'data/repositories/theme_repository_impl.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('📁 Current working directory: ${Directory.current.path}');
  await dotenv.load();
  final themeRepo = ThemeRepositoryImpl();
  final localeRepo = LocaleRepositoryImpl();
  final themeInt = await themeRepo.getThemeMode(); // 0 or 1
  final locale = await localeRepo.getLocale();

  runApp(
    ProviderScope(
      overrides: [
        themeModeProvider.overrideWith(
          (_) => ThemeModeConverter.fromInt(themeInt),
        ),
        localeProvider.overrideWith((_) => locale),
      ],
      child: const WeatherApp(),
    ),
  );
}
