// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
import 'package:mockito/mockito.dart';
import 'package:poyopoyo_weather/core/network/api_response.dart';
import 'package:poyopoyo_weather/domain/entities/forecast_weather.dart';
import 'package:poyopoyo_weather/domain/entities/weather.dart';

void registerAllDummyValues() {
  provideDummy<ApiResponse<Weather>>(const ApiFailure<Weather>('dummy error'));
  provideDummy<ApiResponse<List<ForecastWeather>>>(
    const ApiFailure<List<ForecastWeather>>('dummy'),
  );
}
