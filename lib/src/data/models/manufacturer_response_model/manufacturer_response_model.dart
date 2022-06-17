import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/manufacture/manufacturer.dart';

import '../../../core/utils/log/log.dart';

part 'manufacturer_response_model.g.dart';

@JsonSerializable()
class ManufacturerResponseModel {
  int? code;
  List<Manufacturer>? data;
  String? message;
  String? error;

  ManufacturerResponseModel({
    this.code,
    this.data,
    this.message,
    this.error,
  });

  factory ManufacturerResponseModel.fromJson(Map<String, dynamic> json) {
    return _$ManufacturerResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ManufacturerResponseModelToJson(this);
}
