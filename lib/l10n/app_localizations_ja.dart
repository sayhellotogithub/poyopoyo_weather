// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'ポヨポヨ 天気';

  @override
  String get settings => '設定';

  @override
  String get theme_setting => '🌗 テーマ設定';

  @override
  String get language_setting => '🌐 言語設定';

  @override
  String get light => 'ライト';

  @override
  String get dark => 'ダーク';

  @override
  String get japanese => '日本語';

  @override
  String get english => '英語';

  @override
  String get errorTimeout => '接続がタイムアウトしました';

  @override
  String get errorServer => 'サーバーエラーが発生しました';

  @override
  String get errorUnknown => '不明なエラーが発生しました';

  @override
  String get cityNotFound => '都市が見つかりませんでした';

  @override
  String get searchHint => '都市を検索';

  @override
  String get cancel => 'キャンセル';

  @override
  String get dataNotFound => 'データが見つかりませんでした';

  @override
  String get fiveDayForecast => '5日間予報';

  @override
  String tempHighLow(String max, String min) {
    return '最高 $max° 最低 $min°';
  }
}
