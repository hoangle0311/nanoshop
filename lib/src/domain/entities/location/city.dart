import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()
class City {
  @JsonKey(name: "province_id")
  String? provinceId;
  String? name;
  String? type;
  String? latlng;
  String? location;
  String? position;
  String? left;
  String? top;
  String? alias;

  City({
    this.provinceId,
    this.name,
    this.type,
    this.latlng,
    this.location,
    this.position,
    this.left,
    this.top,
    this.alias,
  });

  factory City.fromJson(Map<String, dynamic> json) =>
      _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}
