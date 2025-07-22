// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastResponseDto _$ForecastResponseDtoFromJson(Map<String, dynamic> json) =>
    ForecastResponseDto(
      list: (json['list'] as List<dynamic>)
          .map((e) => ForecastWeatherDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ForecastResponseDtoToJson(
  ForecastResponseDto instance,
) => <String, dynamic>{'list': instance.list};
