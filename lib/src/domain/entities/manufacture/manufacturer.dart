import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/core/utils/log/log.dart';

part 'manufacturer.g.dart';

@JsonSerializable()
class Manufacturer extends Equatable {
  final String? id;
  final String? name;
  final String? alias;
  final String? order;
  @JsonKey(name: "image_path")
  final String? imagePath;
  @JsonKey(name: "image_name")
  final String? imageName;
  final String? createdTime;
  final String? modifiedTime;
  final String? categoryTrack;
  @JsonKey(name: "manufacturer_id")
  final String? manufacturerId;
  final String? shortdes;
  final String? description;
  final String? address;
  final String? phone;
  final String? metaTitle;
  final String? metaKeywords;
  final String? metaDescription;
  final String? link;

  const Manufacturer({
    this.id,
    this.name,
    this.alias,
    this.order,
    this.imagePath,
    this.imageName,
    this.createdTime,
    this.modifiedTime,
    this.categoryTrack,
    this.manufacturerId,
    this.shortdes,
    this.description,
    this.address,
    this.phone,
    this.metaTitle,
    this.metaKeywords,
    this.metaDescription,
    this.link,
  });

  static const empty = Manufacturer(
    id: '-',
    name: '-',
  );

  factory Manufacturer.fromJson(Map<String, dynamic> json) {
    return _$ManufacturerFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ManufacturerToJson(this);

  @override
  List<Object?> get props => [
        name,
        id,
      ];
}
