// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherInfoDto _$WeatherInfoDtoFromJson(Map<String, dynamic> json) =>
    WeatherInfoDto(
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeatherInfoDtoToJson(WeatherInfoDto instance) =>
    <String, dynamic>{
      'description': instance.description,
      'icon': instance.icon,
    };
