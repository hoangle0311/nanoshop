import 'package:json_annotation/json_annotation.dart';

import 'group_banner.dart';

part 'banner_response_model.g.dart';

@JsonSerializable()
class BannerResponseModel {
  int? code;
  GroupBanner? data;
  String? message;
  String? error;

  BannerResponseModel({
    this.code,
    this.data,
    this.message,
    this.error,
  });

  factory BannerResponseModel.fromJson(Map<String, dynamic> json) {
    return _$BannerResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BannerResponseModelToJson(this);
}
