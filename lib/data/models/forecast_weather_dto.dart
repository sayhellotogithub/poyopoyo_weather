// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
import 'package:json_annotation/json_annotation.dart';
import 'package:poyopoyo_weather/data/models/weather_info_dto.dart';
import 'package:poyopoyo_weather/domain/entities/forecast_weather.dart';

import 'main_info_dto.dart';

part 'forecast_weather_dto.g.dart';

@JsonSerializable()
class ForecastWeatherDto {
  @JsonKey(name: 'dt')
  final int dt;

  @JsonKey(name: 'dt_txt')
  final String dateTimeText;

  final MainInfoDto main;
  final List<WeatherInfoDto> weather;

  ForecastWeatherDto({
    required this.dt,
    required this.dateTimeText,
    required this.main,
    required this.weather,
  });

  factory ForecastWeatherDto.fromJson(Map<String, dynamic> json) =>
      _$ForecastWeatherDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastWeatherDtoToJson(this);

  ForecastWeather toEntity() {
    final localDateTime = DateTime.fromMillisecondsSinceEpoch(
      dt * 1000,
    ).toLocal();

    return ForecastWeather(
      dateTime: localDateTime.toIso8601String(),
      temperature: main.temp,
      condition: weather.isNotEmpty ? weather[0].description : '',
      icon: weather.isNotEmpty ? weather[0].icon : '',
    );
  }
}
