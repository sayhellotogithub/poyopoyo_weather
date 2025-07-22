// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/22
// Description: 
// -------------------------------------------------------------------
import 'forecast_weather_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forecast_response_dto.g.dart';

@JsonSerializable()
class ForecastResponseDto {
  final List<ForecastWeatherDto> list;

  ForecastResponseDto({required this.list});

  factory ForecastResponseDto.fromJson(Map<String, dynamic> json)
  => _$ForecastResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastResponseDtoToJson(this);
}