import 'package:json_annotation/json_annotation.dart';

class Ward {
  @JsonKey(name: "ward_id")
  final String? wardId;
  final String? name;
  final String? type;
  final String? latlng;
  final String? districtId;

 const Ward({
    this.wardId,
    this.name,
    this.type,
    this.latlng,
    this.districtId,
  });


}
