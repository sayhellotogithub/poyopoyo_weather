// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poyopoyo_weather/domain/repositories/locale_repository.dart';

import '../../data/repositories/locale_repository_impl.dart';

final localeProvider = StateProvider<Locale>((ref) => const Locale('ja'));

final localePrefsProvider = Provider<LocaleRepository>((ref) {
  return LocaleRepositoryImpl();
});
