// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/21
// Description:
// -------------------------------------------------------------------
import 'package:json_annotation/json_annotation.dart';

part 'main_info_dto.g.dart';

@JsonSerializable()
class MainInfoDto {
  final double temp;

  @JsonKey(name: 'temp_max')
  final double tempMax;

  @JsonKey(name: 'temp_min')
  final double tempMin;

  const MainInfoDto({
    required this.temp,
    required this.tempMax,
    required this.tempMin,
  });

  factory MainInfoDto.fromJson(Map<String, dynamic> json) =>
      _$MainInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MainInfoDtoToJson(this);
}
