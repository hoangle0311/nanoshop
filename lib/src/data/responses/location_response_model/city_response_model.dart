import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/core/utils/log/log.dart';
import 'package:nanoshop/src/domain/entities/location/city.dart';

part 'city_response_model.g.dart';

@JsonSerializable()
class CityResponseModel {
  int? code;
  List<City>? data;
  String? message;
  String? error;

  CityResponseModel({this.code, this.data, this.message, this.error});

  factory CityResponseModel.fromJson(Map<String, dynamic> json) {
    return _$CityResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CityResponseModelToJson(this);
}
