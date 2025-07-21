// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_weather_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastWeatherDto _$ForecastWeatherDtoFromJson(Map<String, dynamic> json) =>
    ForecastWeatherDto(
      dt: (json['dt'] as num).toInt(),
      dateTimeText: json['dt_txt'] as String,
      main: MainInfoDto.fromJson(json['main'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WeatherInfoDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ForecastWeatherDtoToJson(ForecastWeatherDto instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'dt_txt': instance.dateTimeText,
      'main': instance.main,
      'weather': instance.weather,
    };
