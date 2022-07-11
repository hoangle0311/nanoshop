import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class Banner extends Equatable {
  @JsonKey(name: 'banner_id')
  final String? bannerId;
  @JsonKey(name: 'banner_group_id')
  final String? bannerGroupId;
  @JsonKey(name: 'banner_name')
  final String? bannerName;
  @JsonKey(name: 'banner_description')
  final String? bannerDescription;
  @JsonKey(name: 'banner_src')
  final String? bannerSrc;
  @JsonKey(name: 'banner_width')
  final String? bannerWidth;
  @JsonKey(name: 'banner_height')
  final String? bannerHeight;
  @JsonKey(name: 'banner_link')
  final String? bannerLink;
  @JsonKey(name: 'banner_type')
  final String? bannerType;
  @JsonKey(name: 'start_time')
  final String? startTime;
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey(name: 'banner_video_link')
  final String? bannerVideoLink;
  final String? style;

  const Banner(
      {this.bannerId,
      this.bannerGroupId,
      this.bannerName,
      this.bannerDescription,
      this.bannerSrc,
      this.bannerWidth,
      this.bannerHeight,
      this.bannerLink,
      this.bannerType,
      this.startTime,
      this.endTime,
      this.bannerVideoLink,
      this.style});



  @override
  List<Object?> get props {
    return [
      bannerId,
      bannerGroupId,
      bannerName,
      bannerDescription,
      bannerSrc,
      bannerWidth,
      bannerHeight,
      bannerLink,
      bannerType,
      startTime,
      endTime,
      bannerVideoLink,
      style,
    ];
  }
}
