import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/shop/shop.dart';

part 'shop_model.g.dart';

@JsonSerializable()
class ShopModel extends Shop {
  const ShopModel({
    String? id,
    String? name,
    String? alias,
    String? address,
    String? provinceId,
    String? provinceName,
    String? hotline,
    String? phone,
    String? email,
    String? latlng,
    String? avatarPath,
    String? avatarName,
  }) : super(
          id: id,
          name: name,
          alias: alias,
          address: address,
          provinceId: provinceId,
          provinceName: provinceName,
          hotline: hotline,
          phone: phone,
          email: email,
          latlng: latlng,
          avatarPath: avatarPath,
          avatarName: avatarName,
        );

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return _$ShopModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ShopModelToJson(this);
}
