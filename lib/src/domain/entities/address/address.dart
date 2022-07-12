import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address extends Equatable {
  final String name, phone, city, district, ward, address;
  final String sex;

  const Address({
    required this.name,
    required this.phone,
    required this.city,
    required this.district,
    required this.ward,
    required this.address,
    required this.sex,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  static const empty = Address(
    name: "_",
    phone: "_",
    city: "_",
    district: "_",
    ward: "_",
    address: "_",
    sex: "_",
  );

  Address copyWith({
    String? name,
    String? phone,
    String? city,
    String? district,
    String? address,
    String? ward,
    String? sex,
  }) {
    return Address(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      district: district ?? this.district,
      ward: ward ?? this.ward,
      address: address ?? this.address,
      sex: sex ?? this.sex,
    );
  }

  @override
  List<Object?> get props => [
        name,
        phone,
        city,
        district,
        ward,
        address,
        sex,
      ];
}
