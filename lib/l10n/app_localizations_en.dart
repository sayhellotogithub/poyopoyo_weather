// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PoyoPoyo Weather';

  @override
  String get settings => 'Settings';

  @override
  String get theme_setting => '🌗 Theme Setting';

  @override
  String get language_setting => '🌐 Language Setting';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get japanese => 'Japanese';

  @override
  String get english => 'English';

  @override
  String get errorTimeout => 'Connection timed out';

  @override
  String get errorServer => 'Server error occurred';

  @override
  String get errorUnknown => 'An unknown error occurred';

  @override
  String get cityNotFound => 'City not found';

  @override
  String get searchHint => 'Search city';

  @override
  String get cancel => 'Cancel';

  @override
  String get dataNotFound => 'No data found';

  @override
  String get fiveDayForecast => '5-day forecast';

  @override
  String tempHighLow(String max, String min) {
    return 'High $max° Low $min°';
  }
}
