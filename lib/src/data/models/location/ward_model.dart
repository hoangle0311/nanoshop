import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/location/ward.dart';

part 'ward_model.g.dart';

@JsonSerializable()
class WardModel extends Ward {
  const WardModel({
    String? wardId,
    String? name,
    String? type,
    String? latlng,
  }) : super(
    wardId: wardId,
    name: name,
    type: type,
    latlng: latlng,
  );

  factory WardModel.fromJson(Map<String, dynamic> json) => _$WardModelFromJson(json);

  Map<String, dynamic> toJson() => _$WardModelToJson(this);

}
