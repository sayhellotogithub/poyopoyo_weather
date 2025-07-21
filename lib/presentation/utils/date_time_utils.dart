// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/21
// Description:
// -------------------------------------------------------------------
import 'package:intl/intl.dart';

class DateTimeUtils {
  /// 提取 HH:mm（24小时制）
  static String extractHourMinute(String? dtTxt, {String locale = 'ja'}) {
    if (dtTxt == null) return '';
    try {
      final dt = DateTime.parse(dtTxt).toLocal();
      return DateFormat('HH:mm', locale).format(dt); // 例: 18:00
    } catch (_) {
      return '';
    }
  }

  /// 提取小时（适用于日本语：“18時”、中文：“下午6時”、英文：“6PM”）
  static String formatLocalizedHour(String? dtTxt, {String locale = 'ja'}) {
    if (dtTxt == null) return '';
    try {
      final dt = DateTime.parse(dtTxt).toLocal();

      switch (locale) {
        case 'ja':
          return DateFormat('H時', locale).format(dt); // 例: 18時
        case 'zh':
          return DateFormat('ah時', locale).format(dt); // 例: 下午6時
        case 'en':
          return DateFormat('ha', locale).format(dt); // 例: 6PM
        default:
          return DateFormat('HH:mm', locale).format(dt);
      }
    } catch (_) {
      return '';
    }
  }

  /// 提取 yyyy-MM-dd
  static String extractDate(String? dtTxt) {
    if (dtTxt == null || dtTxt.length < 10) return '';
    return dtTxt.substring(0, 10);
  }

  /// 提取 MM-dd（短日付け）
  static String formatShortDay(String? dtTxt) {
    if (dtTxt == null || dtTxt.length < 10) return '';
    return dtTxt.substring(5, 10); // 例: 07-22
  }

  /// 格式化为 AM/PM hh:mm（12小时制）
  static String formatTo12Hour(String? dtTxt, {String locale = 'en'}) {
    if (dtTxt == null) return '';
    try {
      final dt = DateTime.parse(dtTxt).toLocal();
      return DateFormat('hh:mm a', locale).format(dt); // 例: 06:00 PM
    } catch (_) {
      return '';
    }
  }

  /// 格式化为 HH:mm（24小时制）
  static String formatTo24Hour(String? dtTxt, {String locale = 'ja'}) {
    if (dtTxt == null) return '';
    try {
      final dt = DateTime.parse(dtTxt).toLocal();
      return DateFormat('HH:mm', locale).format(dt); // 例: 18:00
    } catch (_) {
      return '';
    }
  }
}
