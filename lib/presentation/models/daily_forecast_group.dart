// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/21
// Description:
// -------------------------------------------------------------------
import '../../domain/entities/forecast_weather.dart';

class DailyForecastGroup {
  final String day;
  final List<ForecastWeather> hourly;
  final int max;
  final int min;

  DailyForecastGroup({
    required this.day,
    required this.hourly,
    required this.max,
    required this.min,
  });
}
