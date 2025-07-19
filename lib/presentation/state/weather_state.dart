// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description: 
// -------------------------------------------------------------------
import 'package:poyopoyo_weather/domain/entities/weather.dart';
import 'package:poyopoyo_weather/domain/entities/forecast_weather.dart';

class WeatherState {
  final Weather? current;
  final List<ForecastWeather>? forecast;
  final bool isLoading;
  final String? errorMessage;

  WeatherState({
    this.current,
    this.forecast,
    this.isLoading = false,
    this.errorMessage,
  });

  WeatherState copyWith({
    Weather? current,
    List<ForecastWeather>? forecast,
    bool? isLoading,
    String? errorMessage,
  }) {
    return WeatherState(
      current: current ?? this.current,
      forecast: forecast ?? this.forecast,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  factory WeatherState.initial() => WeatherState(isLoading: false);
}
