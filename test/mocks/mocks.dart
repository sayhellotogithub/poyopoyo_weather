// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
import 'package:mockito/annotations.dart';
import 'package:poyopoyo_weather/application/usecases/fetch_current_weather_usecase.dart';
import 'package:poyopoyo_weather/application/usecases/fetch_forecast_usecase.dart';
import 'package:poyopoyo_weather/domain/repositories/weather_repository.dart';

@GenerateMocks([
  WeatherRepository,
  FetchCurrentWeatherUseCase,
  FetchForecastUseCase,
])
void main() {}
