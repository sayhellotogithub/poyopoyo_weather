// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poyopoyo_weather/domain/repositories/theme_repository.dart';
import 'package:poyopoyo_weather/presentation/theme/app_theme.dart';

import '../../data/repositories/theme_repository_impl.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.light; // 可以后续 load 初始化
});

final themePrefsProvider = Provider<ThemeRepository>((ref) {
  return ThemeRepositoryImpl();
});

/// 当前使用的主题数据（可切换返回不同 ThemeData）
final customThemeProvider = Provider<ThemeData>((ref) {
  final mode = ref.watch(themeModeProvider);
  switch (mode) {
    case ThemeMode.dark:
      return AppTheme.darkTheme;
    case ThemeMode.light:
      return AppTheme.lightTheme;
    case ThemeMode.system:
    default:
      final brightness = PlatformDispatcher.instance.platformBrightness;
      return brightness == Brightness.dark
          ? AppTheme.darkTheme
          : AppTheme.lightTheme;
  }
});
