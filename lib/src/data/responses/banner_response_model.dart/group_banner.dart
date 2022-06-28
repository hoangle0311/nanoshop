
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/banner/banner.dart';

part 'group_banner.g.dart';

@JsonSerializable()
class GroupBanner {
  List<Banner>? data;

  GroupBanner({
    this.data,
  });

  factory GroupBanner.fromJson(Map<String, dynamic> json) {
    return _$GroupBannerFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GroupBannerToJson(this);
}
