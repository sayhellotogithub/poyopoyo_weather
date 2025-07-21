// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/20
// Description:
// -------------------------------------------------------------------
import '../../core/network/api_response.dart';
import '../../domain/entities/forecast_weather.dart';
import '../../domain/entities/merged_weather.dart';
import '../../domain/entities/weather.dart';

MergedWeather? mergeResponses(
  ApiResponse<Weather> current,
  ApiResponse<List<ForecastWeather>> forecast,
) {
  if (current is ApiSuccess<Weather> &&
      forecast is ApiSuccess<List<ForecastWeather>>) {
    final Weather currentData = current.data;
    final List<ForecastWeather> forecastData = forecast.data;

    return MergedWeather(current: currentData, forecast: forecastData);
  }
  return null;
}
