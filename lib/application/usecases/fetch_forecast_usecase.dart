// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
import 'package:poyopoyo_weather/core/network/api_response.dart';
import 'package:poyopoyo_weather/domain/entities/forecast_weather.dart';
import 'package:poyopoyo_weather/domain/repositories/weather_repository.dart';

class FetchForecastUseCase {
  final WeatherRepository repository;

  FetchForecastUseCase(this.repository);

  Future<ApiResponse<List<ForecastWeather>>> execute(
    String cityName, {
    String lang = 'ja',
  }) {
    return repository.fetchForecast(cityName: cityName, lang: lang);
  }
}
