// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/20
// Description:
// -------------------------------------------------------------------
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/usecases/fetch_current_weather_usecase.dart';
import '../../application/usecases/fetch_weather_by_location_usecase.dart';
import '../../core/base/state_with_error_key.dart';
import '../../core/network/api_response.dart';
import '../../domain/entities/weather.dart';
import '../providers/weather_providers.dart';

class WeatherListState implements StateWithErrorKey {
  final List<Weather> weatherList;
  final bool isLoading;
  final String? error;

  WeatherListState({
    this.weatherList = const [],
    this.isLoading = false,
    this.error,
  });

  WeatherListState copyWith({
    List<Weather>? weatherList,
    bool? isLoading,
    String? error,
  }) {
    return WeatherListState(
      weatherList: weatherList ?? this.weatherList,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  String? get errorKey => error;
}

class WeatherListViewModel extends Notifier<WeatherListState> {
  late final FetchWeatherByLocationUseCase _fetchWeatherByLocationUseCase;
  late final FetchCurrentWeatherUseCase _currentWeatherUseCase;

  @override
  WeatherListState build() {
    _fetchWeatherByLocationUseCase = ref.watch(
      fetchCurrentWeatherByLocationUseCaseProvider,
    );
    _currentWeatherUseCase = ref.watch(fetchCurrentWeatherUseCaseProvider);

    return WeatherListState();
  }

  Future<void> addWeatherByLocation(double lat, double lon, String lang) async {
    state = state.copyWith(isLoading: true);
    final currentRes = await _fetchWeatherByLocationUseCase.execute(
      lat,
      lon,
      lang: lang,
    );

    if (currentRes is ApiFailure) {
      state = state.copyWith(
        isLoading: false,
        error: (currentRes as ApiFailure).messageKey,
      );
      return;
    }
    if (currentRes is ApiSuccess) {
      final updatedList = <Weather>[
        ...state.weatherList,
        (currentRes as ApiSuccess).data,
      ];
      state = state.copyWith(weatherList: updatedList, isLoading: false);
    }
  }

  Future<void> addWeatherByCity(String cityName, String lang) async {
    state = state.copyWith(isLoading: true);
    final currentRes = await _currentWeatherUseCase.execute(
      cityName,
      lang: lang,
    );

    if (currentRes is ApiFailure) {
      state = state.copyWith(
        isLoading: false,
        error: (currentRes as ApiFailure).messageKey,
      );
      return;
    }
    if (currentRes is ApiSuccess) {
      final updatedList = <Weather>[
        ...state.weatherList,
        (currentRes as ApiSuccess).data,
      ];
      state = state.copyWith(weatherList: updatedList, isLoading: false);
    }
  }
}
