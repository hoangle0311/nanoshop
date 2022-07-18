import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/data/models/location/district_model.dart';

import '../../../domain/entities/location/district.dart';

part 'district_response_model.g.dart';

@JsonSerializable()
class DistrictResponseModel {
  int? code;
  List<DistrictModel>? data;
  String? message;
  String? error;

  DistrictResponseModel({
    this.code,
    this.data,
    this.message,
    this.error,
  });

  factory DistrictResponseModel.fromJson(Map<String, dynamic> json) {
    return _$DistrictResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DistrictResponseModelToJson(this);
}
