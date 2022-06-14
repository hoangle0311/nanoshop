import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/banner/banner.dart';

part 'banner_response_model.g.dart';

@JsonSerializable()
class BannerResponseModel {
  int? code;
  List<Banner>? data;
  String? message;
  String? error;

  BannerResponseModel({
    this.code,
    this.data,
    this.message,
    this.error,
  });

  factory BannerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerResponseModelToJson(this);
}
