import 'package:json_annotation/json_annotation.dart';

part 'image_product.g.dart';

@JsonSerializable()
class ImageProduct {
  @JsonKey(name: "img_id")
  String? imgId;
  String? name;
  String? path;
  @JsonKey(name: "display_name")
  String? displayName;
  String? alias;
  String? height;
  String? width;
  String? order;

  ImageProduct({
    this.imgId,
    this.name,
    this.path,
    this.displayName,
    this.alias,
    this.height,
    this.width,
    this.order,
  });

  factory ImageProduct.fromJson(Map<String, dynamic> json) {
    return _$ImageProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ImageProductToJson(this);
}
