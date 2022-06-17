import 'package:equatable/equatable.dart';

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

  static const empty = Address(
    name: "_",
    phone: "_",
    city: "_",
    district: "_",
    ward: "_",
    address: "_",
    sex: "_",
  );

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
