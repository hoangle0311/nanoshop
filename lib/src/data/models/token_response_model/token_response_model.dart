import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/token/token.dart';

part 'token_response_model.g.dart';

@JsonSerializable()
class TokenResponseModel {
  int? code;
  Token? data;
  String? message;
  String? error;

  TokenResponseModel({
    this.code,
    this.data,
    this.message,
    this.error,
  });

  factory TokenResponseModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return _$TokenResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TokenResponseModelToJson(this);
}
