// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poyopoyo_weather/application/usecases/fetch_current_weather_usecase.dart';
import 'package:poyopoyo_weather/application/usecases/fetch_forecast_usecase.dart';
import 'package:poyopoyo_weather/core/network/api_response.dart';

import '../state/weather_state.dart';

class WeatherViewModel extends StateNotifier<WeatherState> {
  final FetchCurrentWeatherUseCase fetchCurrentWeather;
  final FetchForecastUseCase fetchForecast;

  WeatherViewModel({
    required this.fetchCurrentWeather,
    required this.fetchForecast,
  }) : super(WeatherState.initial());

  Future<void> loadWeather(String cityName) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final currentRes = await fetchCurrentWeather.execute(cityName);
    final forecastRes = await fetchForecast.execute(cityName);

    if (currentRes is ApiFailure && forecastRes is ApiFailure) {
      // 两个都失败，合并错误信息
      state = state.copyWith(
        isLoading: false,
        errorMessage:
            '${(currentRes as ApiFailure).message}\n${(forecastRes as ApiFailure).message}',
      );
    } else if (currentRes is ApiFailure) {
      state = state.copyWith(
        isLoading: false,
        forecast: (forecastRes as ApiSuccess).data,
        errorMessage: (currentRes as ApiFailure).message,
      );
    } else if (forecastRes is ApiFailure) {
      state = state.copyWith(
        isLoading: false,
        current: (currentRes as ApiSuccess).data,
        errorMessage: (forecastRes as ApiFailure).message,
      );
    } else {
      // 全部成功
      state = state.copyWith(
        current: (currentRes as ApiSuccess).data,
        forecast: (forecastRes as ApiSuccess).data,
        isLoading: false,
      );
    }
  }
}
