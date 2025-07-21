// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
import 'package:json_annotation/json_annotation.dart';
import 'package:poyopoyo_weather/domain/entities/weather.dart';

part 'weather_dto.g.dart';

@JsonSerializable()
class WeatherDto {
  final String name;
  final Map<String, dynamic> main;
  final List<dynamic> weather;
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
      temperature: (main['temp'] as num).toDouble(),
      maxTemp: (main['temp_max'] as num).toDouble(),
      minTemp: (main['temp_min'] as num).toDouble(),
      condition: weather.isNotEmpty ? weather[0]['description'] ?? '' : '',
      icon: weather.isNotEmpty ? weather[0]['icon'] ?? '' : '',
      time: DateTime.fromMillisecondsSinceEpoch(
        dt * 1000,
      ).toLocal().toIso8601String().substring(11, 16),
    );
  }
}
