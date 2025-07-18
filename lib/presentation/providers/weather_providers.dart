// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description: 
// -------------------------------------------------------------------
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poyopoyo_weather/core/network/dio_client.dart';
import 'package:poyopoyo_weather/data/repositories/weather_repository_impl.dart';
import 'package:poyopoyo_weather/domain/entities/weather.dart';

final dioProvider = Provider((ref) => DioClient().dio);

final weatherRepositoryProvider = Provider((ref) {
  final apiKey = dotenv.env['OPENWEATHER_API_KEY'];
  final dio = ref.watch(dioProvider);
  return WeatherRepositoryImpl(dio: dio, apiKey:apiKey ?? '');
});

// final currentWeatherProvider = FutureProvider.family<Weather, String>((ref, city) async {
//   final repo = ref.watch(weatherRepositoryProvider);
//   return repo.fetchCurrentWeather(city);
// });

final weatherListProvider = StateProvider<List<Weather>>((ref) => [
  Weather(
    city: '東京',
    temperature: 29,
    maxTemp: 32,
    minTemp: 25,
    condition: '曇り',
    time: '18:04',
  ),
  Weather(
    city: '中野区',
    temperature: 29,
    maxTemp: 32,
    minTemp: 25,
    condition: '曇り',
    time: '18:04',
  )
]);
