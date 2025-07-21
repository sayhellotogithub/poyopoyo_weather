// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
import 'package:json_annotation/json_annotation.dart';
import 'package:poyopoyo_weather/domain/entities/forecast_weather.dart';

part 'forecast_weather_dto.g.dart';

@JsonSerializable()
class ForecastWeatherDto {
  @JsonKey(name: 'dt')
  final int dt;

  @JsonKey(name: 'dt_txt')
  final String dateTimeText;

  final Map<String, dynamic> main;

  final List<dynamic> weather;

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
    return ForecastWeather(
      dateTime: dateTimeText,
      temperature: (main['temp'] as num).toDouble(),
      condition: weather.isNotEmpty ? weather[0]['description'] ?? '' : '',
      icon: weather.isNotEmpty ? weather[0]['icon'] ?? '' : '',
    );
  }
}
