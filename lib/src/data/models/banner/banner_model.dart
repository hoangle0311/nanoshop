import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/banner/banner.dart';

part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel extends Banner {
  const BannerModel({
    String? bannerId,
    String? bannerLink,
    String? bannerSrc,
  }) : super(
          bannerId: bannerId,
          bannerLink: bannerLink,
          bannerSrc: bannerSrc,
        );

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
