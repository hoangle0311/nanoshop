import 'package:json_annotation/json_annotation.dart';

class District {
  @JsonKey(name: "district_id")
  final String? districtId;
  final String? name;
  final String? type;
  final String? latlng;
  final String? provinceId;

  const District({
    this.districtId,
    this.name,
    this.type,
    this.latlng,
    this.provinceId,
  });
}
