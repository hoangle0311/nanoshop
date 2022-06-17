import 'package:json_annotation/json_annotation.dart';

part 'shop.g.dart';

@JsonSerializable()
class Shop {
  String? id;
  String? name;
  String? alias;
  String? status;
  String? address;
  @JsonKey(name: "province_id")
  String? provinceId;
  @JsonKey(name: "province_name")
  String? provinceName;

  String? districtId;
  @JsonKey(name: "district_name")
  String? districtName;
  String? wardId;
  @JsonKey(name: "ward_name")
  String? wardName;
  String? hotline;
  String? phone;
  String? email;
  String? hours;
  @JsonKey(name: "avatar_path")
  String? avatarPath;
  @JsonKey(name: "avatar_name")
  String? avatarName;
  String? createdTime;
  String? modifiedTime;
  String? siteId;
  String? shopId;
  String? latlng;
  String? group;
  String? order;
  String? metaTitle;
  String? metaKeywords;
  String? metaDescription;
  String? shopStoreDesc;

  Shop({
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
    this.createdTime,
    this.modifiedTime,
    this.siteId,
    this.shopId,
    this.latlng,
    this.group,
    this.order,
    this.metaTitle,
    this.metaKeywords,
    this.metaDescription,
    this.shopStoreDesc,
  });


  factory Shop.fromJson(Map<String, dynamic> json) {
    return _$ShopFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ShopToJson(this);
}
