// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
import 'package:dio/dio.dart';
import 'package:poyopoyo_weather/core/network/api_response.dart';
import 'package:poyopoyo_weather/core/network/dio_helper.dart';
import 'package:poyopoyo_weather/data/models/city_dto.dart';
import 'package:poyopoyo_weather/domain/entities/city.dart';
import 'package:poyopoyo_weather/domain/repositories/city_repository.dart';

class CityRepositoryImpl implements CityRepository {
  final Dio dio;
  final String apiKey;

  CityRepositoryImpl({required this.dio, required this.apiKey});

  @override
  Future<ApiResponse<List<City>>> searchCities(String keyword) {
    return safeRequest(() async {
      final res = await dio.get(
        'geo/1.0/direct',
        queryParameters: {'q': keyword, 'limit': 5, 'appid': apiKey},
      );
      final list = (res.data as List)
          .map((item) => CityDto.fromJson(item).toEntity())
          .toList();
      return list;
    });
  }
}
