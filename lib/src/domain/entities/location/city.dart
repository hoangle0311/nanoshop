import 'package:json_annotation/json_annotation.dart';


class City {
  @JsonKey(name: "province_id")
  final String? provinceId;
  final String? name;
  final String? type;
  final String? latlng;
  final String? location;
  final String? position;

  const City({
    this.provinceId,
    this.name,
    this.type,
    this.latlng,
    this.location,
    this.position,
  });
}
