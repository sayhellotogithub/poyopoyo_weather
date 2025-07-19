// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDto _$WeatherDtoFromJson(Map<String, dynamic> json) => WeatherDto(
  name: json['name'] as String,
  main: json['main'] as Map<String, dynamic>,
  weather: json['weather'] as List<dynamic>,
  dt: (json['dt'] as num).toInt(),
);

Map<String, dynamic> _$WeatherDtoToJson(WeatherDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'main': instance.main,
      'weather': instance.weather,
      'dt': instance.dt,
    };
