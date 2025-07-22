// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/22
// Description: 
// -------------------------------------------------------------------
// city_api.dart
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/city_dto.dart';

part 'city_api.g.dart';

@RestApi()
abstract class CityApi {
  factory CityApi(Dio dio, {String baseUrl}) = _CityApi;

  @GET('geo/1.0/direct')
  Future<List<CityDto>> searchCities(
      @Query('q') String keyword,
      @Query('limit') int limit,
      @Query('appid') String apiKey,
      );
}
