import 'package:json_annotation/json_annotation.dart';

part 'shop.g.dart';

@JsonSerializable()
class Shop {
  final String? id;
  final String? name;
  final String? alias;
  final String? status;
  final String? address;
  @JsonKey(name: "province_id")
  final String? provinceId;
  @JsonKey(name: "province_name")
  final String? provinceName;
  final String? districtId;
  @JsonKey(name: "district_name")
  final String? districtName;
  final String? wardId;
  @JsonKey(name: "ward_name")
  final String? wardName;
  final String? hotline;
  final String? phone;
  final String? email;
  final String? hours;
  @JsonKey(name: "avatar_path")
  final String? avatarPath;
  @JsonKey(name: "avatar_name")
  final String? avatarName;
  final String? siteId;
  final String? shopId;
  final String? latlng;

  const Shop({
    this.id,
    this.name,
    this.alias,
    this.status,
    this.address,
    this.provinceId,
    this.provinceName,
    this.districtId,
    this.districtName,
    this.wardId,
    this.wardName,
    this.hotline,
    this.phone,
    this.email,
    this.hours,
    this.avatarPath,
    this.avatarName,
    this.siteId,
    this.shopId,
    this.latlng,
  });


}
