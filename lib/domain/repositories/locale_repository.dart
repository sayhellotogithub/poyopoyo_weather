// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------
import 'dart:ui';

abstract class LocaleRepository {
  Future<Locale> getLocale();

  Future<void> saveLocale(Locale locale);
}
