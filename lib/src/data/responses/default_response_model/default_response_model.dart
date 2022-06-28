import 'package:json_annotation/json_annotation.dart';

import '../../../core/utils/log/log.dart';

part 'default_response_model.g.dart';

@JsonSerializable()
class DefaultResponseModel {
  int? code;
  String? message;
  String? error;

  DefaultResponseModel({
    this.code,
    this.message,
    this.error,
  });

  factory DefaultResponseModel.fromJson(Map<String, dynamic> json) {
    return _$DefaultResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DefaultResponseModelToJson(this);
}
