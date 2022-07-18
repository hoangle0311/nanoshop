import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/location/city.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel extends City {
  const CityModel({
    String? provinceId,
    String? name,
    String? type,
    String? latlng,
    String? location,
    String? position,
  }) : super(
          provinceId: provinceId,
          name: name,
          type: type,
          latlng: latlng,
          location: location,
          position: position,
        );

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}
