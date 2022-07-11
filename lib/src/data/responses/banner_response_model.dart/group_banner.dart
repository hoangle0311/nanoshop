
import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/data/models/banner/banner_model.dart';

import '../../../domain/entities/banner/banner.dart';

part 'group_banner.g.dart';

@JsonSerializable()
class GroupBanner {
  List<BannerModel>? data;

  GroupBanner({
    this.data,
  });

  factory GroupBanner.fromJson(Map<String, dynamic> json) {
    return _$GroupBannerFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GroupBannerToJson(this);
}
