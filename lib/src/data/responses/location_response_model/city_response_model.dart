import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/data/models/location/city_model.dart';

part 'city_response_model.g.dart';

@JsonSerializable()
class CityResponseModel {
  int? code;
  List<CityModel>? data;
  String? message;
  String? error;

  CityResponseModel({this.code, this.data, this.message, this.error});

  factory CityResponseModel.fromJson(Map<String, dynamic> json) {
    return _$CityResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CityResponseModelToJson(this);
}
