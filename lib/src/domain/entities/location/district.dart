import 'package:json_annotation/json_annotation.dart';

part 'district.g.dart';

@JsonSerializable()
class District {
  @JsonKey(name: "district_id")
  String? districtId;
  String? name;
  String? type;
  String? latlng;
  String? provinceId;

  District({
    this.districtId,
    this.name,
    this.type,
    this.latlng,
    this.provinceId,
  });

  factory District.fromJson(Map<String, dynamic> json) =>
      _$DistrictFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictToJson(this);
}
