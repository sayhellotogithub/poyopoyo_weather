// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/20
// Description:
// -------------------------------------------------------------------
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poyopoyo_weather/application/usecases/fetch_forecaset_by_location_usecase.dart';
import 'package:poyopoyo_weather/domain/entities/merged_weather.dart';

import '../../application/usecases/fetch_current_weather_usecase.dart';
import '../../application/usecases/fetch_forecast_usecase.dart';
import '../../application/usecases/fetch_weather_by_location_usecase.dart';
import '../../core/network/api_response.dart';
import '../utils/merge_responses.dart';

class WeatherListState {
  final List<MergedWeather> weatherList;
  final bool isLoading;
  final String? error;

  WeatherListState({
    this.weatherList = const [],
    this.isLoading = false,
    this.error,
  });

  WeatherListState copyWith({
    List<MergedWeather>? weatherList,
    bool? isLoading,
    String? error,
  }) {
    return WeatherListState(
      weatherList: weatherList ?? this.weatherList,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class WeatherListViewModel extends StateNotifier<WeatherListState> {
  final FetchWeatherByLocationUseCase fetchWeatherByLocationUseCase;
  final FetchForecastByLocationUseCase fetchForecastByLocationUseCase;
  final FetchForecastUseCase forecastUseCase;
  final FetchCurrentWeatherUseCase currentWeatherUseCase;

  WeatherListViewModel({
    required this.currentWeatherUseCase,
    required this.forecastUseCase,
    required this.fetchWeatherByLocationUseCase,
    required this.fetchForecastByLocationUseCase,
  }) : super(WeatherListState());

  Future<void> addWeatherByLocation(double lat, double lon, String lang) async {
    state = state.copyWith(isLoading: true);
    final currentRes = await fetchWeatherByLocationUseCase.execute(
      lat,
      lon,
      lang: lang,
    );
    final forecastRes = await fetchForecastByLocationUseCase.execute(
      lat,
      lon,
      lang: lang,
    );

    if (currentRes is ApiFailure || forecastRes is ApiFailure) {
      final message = (currentRes is ApiFailure)
          ? (currentRes as ApiFailure).message
          : (forecastRes as ApiFailure).message;
      state = state.copyWith(isLoading: false, error: message);
      return;
    }

    final merged = mergeResponses(currentRes, forecastRes);
    if (merged != null) {
      final updatedList = [...state.weatherList, merged];
      state = state.copyWith(weatherList: updatedList, isLoading: false);
    } else {
      state = state.copyWith(isLoading: false, error: 'データ統合失敗');
    }
  }

  Future<void> addWeatherByCity(String cityName, String lang) async {
    state = state.copyWith(isLoading: true);
    final currentRes = await currentWeatherUseCase.execute(cityName);
    final forecastRes = await forecastUseCase.execute(cityName, lang: lang);

    if (currentRes is ApiFailure || forecastRes is ApiFailure) {
      final message = (currentRes is ApiFailure)
          ? (currentRes as ApiFailure).message
          : (forecastRes as ApiFailure).message;
      state = state.copyWith(isLoading: false, error: message);
      return;
    }

    final merged = mergeResponses(currentRes, forecastRes);
    if (merged != null) {
      final updatedList = [...state.weatherList, merged];
      state = state.copyWith(weatherList: updatedList, isLoading: false);
    } else {
      state = state.copyWith(isLoading: false, error: 'データ統合失敗');
    }
  }
}
