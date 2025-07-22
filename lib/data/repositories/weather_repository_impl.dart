// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------
import 'package:poyopoyo_weather/core/network/api_response.dart';
import 'package:poyopoyo_weather/core/network/dio_helper.dart';
import 'package:poyopoyo_weather/domain/entities/forecast_weather.dart';
import 'package:poyopoyo_weather/domain/entities/weather.dart';
import 'package:poyopoyo_weather/domain/repositories/weather_repository.dart';

import '../network/weather_api.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApi api;
  final String apiKey;

  WeatherRepositoryImpl({required this.api, required this.apiKey});

  @override
  Future<ApiResponse<Weather>> fetchCurrentWeather({
    required String cityName,
    String lang = 'ja',
  }) {
    return safeRequest(() async {
      final dto = await api.fetchCurrentByCity(
        cityName,
        apiKey,
        lang,
        'metric',
      );
      return dto.toEntity();
    });
  }

  @override
  Future<ApiResponse<List<ForecastWeather>>> fetchForecast({
    required String cityName,
    String lang = 'ja',
  }) {
    return safeRequest(() async {
      final dto = await api.fetchForecast(cityName, apiKey, lang, 'metric');
      return dto.list.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<ApiResponse<Weather>> fetchCurrentWeatherByLocation({
    required double lat,
    required double lon,
    String lang = 'ja',
  }) {
    return safeRequest(() async {
      final dto = await api.fetchCurrentByLocation(
        lat,
        lon,
        apiKey,
        lang,
        'metric',
      );
      return dto.toEntity();
    });
  }

  @override
  Future<ApiResponse<List<ForecastWeather>>> fetchForecastByLocation({
    required double lat,
    required double lon,
    String lang = 'ja',
  }) {
    return safeRequest(() async {
      final dto = await api.fetchForecastByLocation(
        lat,
        lon,
        apiKey,
        lang,
        'metric',
      );
      return dto.list.map((dto) => dto.toEntity()).toList();
    });
  }
}
