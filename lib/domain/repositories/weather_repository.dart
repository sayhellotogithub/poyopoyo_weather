// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------

import 'package:poyopoyo_weather/core/network/api_response.dart';
import 'package:poyopoyo_weather/domain/entities/weather.dart';

import '../entities/forecast_weather.dart';

abstract class WeatherRepository {
  Future<ApiResponse<Weather>> fetchCurrentWeather({
    required String cityName,
    String lang = 'ja',
  });
  Future<ApiResponse<List<ForecastWeather>>> fetchForecast({
    required String cityName,
    String lang = 'ja',
  });
}
