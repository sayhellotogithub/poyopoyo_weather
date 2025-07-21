// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainInfoDto _$MainInfoDtoFromJson(Map<String, dynamic> json) => MainInfoDto(
  temp: (json['temp'] as num).toDouble(),
  tempMax: (json['temp_max'] as num).toDouble(),
  tempMin: (json['temp_min'] as num).toDouble(),
);

Map<String, dynamic> _$MainInfoDtoToJson(MainInfoDto instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'temp_max': instance.tempMax,
      'temp_min': instance.tempMin,
    };
