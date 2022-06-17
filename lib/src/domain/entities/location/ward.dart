import 'package:json_annotation/json_annotation.dart';

part 'ward.g.dart';

@JsonSerializable()
class Ward {
  @JsonKey(name: "ward_id")
  String? wardId;
  String? name;
  String? type;
  String? latlng;
  String? districtId;

  Ward({
    this.wardId,
    this.name,
    this.type,
    this.latlng,
    this.districtId,
  });

  factory Ward.fromJson(Map<String, dynamic> json) =>
      _$WardFromJson(json);

  Map<String, dynamic> toJson() => _$WardToJson(this);
}
