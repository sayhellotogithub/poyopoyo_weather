// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------
import 'package:dio/dio.dart';
import 'package:poyopoyo_weather/core/network/api_response.dart';
import 'package:poyopoyo_weather/core/network/dio_helper.dart';
import 'package:poyopoyo_weather/domain/entities/forecast_weather.dart';
import 'package:poyopoyo_weather/domain/entities/weather.dart';
import 'package:poyopoyo_weather/domain/repositories/weather_repository.dart';

import '../models/forecast_weather_dto.dart';
import '../models/weather_dto.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final Dio dio;
  final String apiKey;

  WeatherRepositoryImpl({required this.dio, required this.apiKey});

  @override
  Future<ApiResponse<Weather>> fetchCurrentWeather({
    required String cityName,
    String lang = 'ja',
  }) {
    return safeRequest(() async {
      final res = await dio.get(
        'weather',
        queryParameters: {
          'q': cityName,
          'appid': apiKey,
          'lang': lang,
          'units': 'metric',
        },
      );
      final dto = WeatherDto.fromJson(res.data);
      return dto.toEntity();
    });
  }

  @override
  Future<ApiResponse<List<ForecastWeather>>> fetchForecast({
    required String cityName,
    String lang = 'ja',
  }) {
    return safeRequest(() async {
      final res = await dio.get(
        'forecast',
        queryParameters: {
          'q': cityName,
          'appid': apiKey,
          'units': 'metric',
          'lang': lang,
        },
      );

      final list = res.data['list'] as List<dynamic>;
      final forecasts = list
          .map((e) => ForecastWeatherDto.fromJson(e).toEntity())
          .toList();

      return forecasts;
    });
  }
}
