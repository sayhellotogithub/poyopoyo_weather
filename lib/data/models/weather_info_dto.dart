// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/21
// Description:
// -------------------------------------------------------------------
import 'package:json_annotation/json_annotation.dart';

part 'weather_info_dto.g.dart';

@JsonSerializable()
class WeatherInfoDto {
  final String description;
  final String icon;

  WeatherInfoDto({required this.description, required this.icon});

  factory WeatherInfoDto.fromJson(Map<String, dynamic> json) =>
      _$WeatherInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherInfoDtoToJson(this);
}
