// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:poyopoyo_weather/application/usecases/fetch_current_weather_usecase.dart';
import 'package:poyopoyo_weather/application/usecases/fetch_forecast_usecase.dart';
import 'package:poyopoyo_weather/core/network/api_response.dart';

import '../../domain/entities/forecast_weather.dart';
import '../models/daily_forecast_group.dart';
import '../state/weather_state.dart';
import '../utils/date_time_utils.dart';

class WeatherViewModel extends StateNotifier<WeatherState> {
  final FetchCurrentWeatherUseCase fetchCurrentWeather;
  final FetchForecastUseCase fetchForecast;

  WeatherViewModel({
    required this.fetchCurrentWeather,
    required this.fetchForecast,
  }) : super(WeatherState.initial());

  Future<void> loadWeather(String cityName, String lang) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final currentRes = await fetchCurrentWeather.execute(cityName, lang: lang);
    final forecastRes = await fetchForecast.execute(cityName);

    if (currentRes is ApiFailure && forecastRes is ApiFailure) {
      state = state.copyWith(
        isLoading: false,
        errorMessage:
            '${(currentRes as ApiFailure).messageKey}\n${(forecastRes as ApiFailure).messageKey}',
      );
    } else if (currentRes is ApiFailure) {
      state = state.copyWith(
        isLoading: false,
        forecast: (forecastRes as ApiSuccess).data,
        errorMessage: (currentRes as ApiFailure).messageKey,
      );
    } else if (forecastRes is ApiFailure) {
      state = state.copyWith(
        isLoading: false,
        current: (currentRes as ApiSuccess).data,
        errorMessage: (forecastRes as ApiFailure).messageKey,
      );
    } else {
      state = state.copyWith(
        current: (currentRes as ApiSuccess).data,
        forecast: (forecastRes as ApiSuccess).data,
        isLoading: false,
      );
    }
  }
  List<DailyForecastGroup> get groupedForecastByDay {
    final forecastList = state.forecast;
    if (forecastList == null || forecastList.isEmpty) return [];

    final map = <String, List<ForecastWeather>>{};
    forecastList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    for (var item in forecastList) {
      Logger().d('📅 ${item.dateTime} 🌡️ ${item.temperature}°C');
      final day = DateTimeUtils.extractDate(item.dateTime);
      map.putIfAbsent(day, () => []).add(item);
    }

    final today = DateTimeUtils.extractDate(DateTime.now().toIso8601String());

    return map.entries
        .where((entry) => entry.key != today)
        .map((entry) {
      final values = entry.value;
      return DailyForecastGroup(
        day: entry.key.substring(5), // MM-DD
        hourly: values,
        max: values.map((e) => e.temperature).reduce((a, b) => a > b ? a : b).toInt(),
        min: values.map((e) => e.temperature).reduce((a, b) => a < b ? a : b).toInt(),
      );
    })
        .toList();
  }
}
