
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/location/ward.dart';

part 'ward_response_model.g.dart';

@JsonSerializable()
class WardResponseModel {
  int? code;
  List<Ward>? data;
  String? message;
  String? error;

  WardResponseModel({this.code, this.data, this.message, this.error});

  factory WardResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WardResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WardResponseModelToJson(this);
}