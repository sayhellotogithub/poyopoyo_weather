// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
import 'package:json_annotation/json_annotation.dart';
import 'package:poyopoyo_weather/data/models/weather_info_dto.dart';
import 'package:poyopoyo_weather/domain/entities/weather.dart';

import 'main_info_dto.dart';

part 'weather_dto.g.dart';

@JsonSerializable()
class WeatherDto {
  final String name;
  final MainInfoDto main;
  final List<WeatherInfoDto> weather;
  final int dt;

  WeatherDto({
    required this.name,
    required this.main,
    required this.weather,
    required this.dt,
  });

  factory WeatherDto.fromJson(Map<String, dynamic> json) =>
      _$WeatherDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDtoToJson(this);

  Weather toEntity() {
    return Weather(
      city: name,
      temperature: main.temp,
      maxTemp: main.tempMax,
      minTemp: main.tempMin,
      condition: weather.isNotEmpty ? weather[0].description : '',
      icon: weather.isNotEmpty ? weather[0].icon : '',
      time: DateTime.fromMillisecondsSinceEpoch(
        dt * 1000,
      ).toLocal().toIso8601String().substring(11, 16), // "HH:mm"
    );
  }
}
