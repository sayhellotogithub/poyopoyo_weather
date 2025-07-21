// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:Encapsulates current weather and forecast
// -------------------------------------------------------------------
import 'package:poyopoyo_weather/domain/entities/weather.dart';

import 'forecast_weather.dart';

class MergedWeather {
  final Weather current;
  final List<ForecastWeather> forecast;

  MergedWeather({required this.current, required this.forecast});
}
