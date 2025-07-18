// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description: 
// -------------------------------------------------------------------
import 'package:dio/dio.dart';
import 'package:poyopoyo_weather/domain/entities/weather.dart';
import 'package:poyopoyo_weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final Dio dio;
  final String apiKey;

  WeatherRepositoryImpl({required this.dio, required this.apiKey});

  // @override
  // Future<Weather> fetchCurrentWeather(String cityName) async {
  //   // dio 呼び出し同前
  //   final response = await dio.get(
  //     'https://api.openweathermap.org/data/2.5/weather',
  //     queryParameters: {
  //       'q': cityName,
  //       'appid': apiKey,
  //       'units': 'metric', // 温度単位をメートル法に設定
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     // レスポンスから Weather オブジェクトを生成
  //     return Weather.fromJson(response.data);
  //   } else {
  //     // エラーハンドリング
  //     throw Exception('Failed to load weather data: ${response.statusCode}');
  //   }
  // }
}