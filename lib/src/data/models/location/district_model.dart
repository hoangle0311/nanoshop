import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/location/district.dart';

part 'district_model.g.dart';

@JsonSerializable()
class DistrictModel extends District {
  const DistrictModel({
    String? districtId,
    String? name,
    String? type,
    String? latlng,
  }) : super(
    districtId: districtId,
    name: name,
    type: type,
    latlng: latlng,
  );

  factory DistrictModel.fromJson(Map<String, dynamic> json) =>
      _$DistrictModelFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictModelToJson(this);
}
