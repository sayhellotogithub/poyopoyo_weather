// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/22
// Description:
// -------------------------------------------------------------------
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/forecast_response_dto.dart';
import '../models/weather_dto.dart';

part 'weather_api.g.dart';

@RestApi()
abstract class WeatherApi {
  factory WeatherApi(Dio dio, {String baseUrl}) = _WeatherApi;

  @GET('data/2.5/weather')
  Future<WeatherDto> fetchCurrentByCity(
    @Query('q') String cityName,
    @Query('appid') String apiKey,
    @Query('lang') String lang,
    @Query('units') String units,
  );

  @GET('data/2.5/weather')
  Future<WeatherDto> fetchCurrentByLocation(
    @Query('lat') double lat,
    @Query('lon') double lon,
    @Query('appid') String apiKey,
    @Query('lang') String lang,
    @Query('units') String units,
  );

  @GET('data/2.5/forecast')
  Future<ForecastResponseDto> fetchForecast(
    @Query('q') String cityName,
    @Query('appid') String apiKey,
    @Query('lang') String lang,
    @Query('units') String units,
  );

  @GET('data/2.5/forecast')
  Future<ForecastResponseDto> fetchForecastByLocation(
    @Query('lat') double lat,
    @Query('lon') double lon,
    @Query('appid') String apiKey,
    @Query('lang') String lang,
    @Query('units') String units,
  );
}
