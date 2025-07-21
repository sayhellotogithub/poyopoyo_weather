// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description: DTO for City API response with JSON annotations
// -------------------------------------------------------------------

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/city.dart';

part 'city_dto.g.dart';

@JsonSerializable()
class CityDto {
  final String name;
  final String country;
  final double lat;
  final double lon;
  final String? state;

  @JsonKey(name: 'local_names')
  final Map<String, String>? localNames;

  const CityDto({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
    this.state,
    this.localNames,
  });

  factory CityDto.fromJson(Map<String, dynamic> json) =>
      _$CityDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CityDtoToJson(this);

  City toEntity() {
    return City(
      name: name,
      country: country,
      lat: lat,
      lon: lon,
      state: state,
      localNames: localNames,
    );
  }
}
