part of 'address_bloc.dart';

@immutable
abstract class AddressEvent extends Equatable {}

class CheckLocalAddress extends AddressEvent {
  @override
  List<Object?> get props => [];
}

class SetLocalAddress extends AddressEvent {
  final Address address;

  SetLocalAddress({
    required this.address,
  });

  @override
  List<Object?> get props => [address];
}

class LocationNameChanged extends AddressEvent {
  final String name;

  LocationNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class LocationPhoneChanged extends AddressEvent {
  final String phone;

  LocationPhoneChanged(this.phone);

  @override
  List<Object> get props => [phone];
}

class LocationAddressChanged extends AddressEvent {
  final String address;

  LocationAddressChanged(this.address);

  @override
  List<Object> get props => [address];
}

class LocationSexChanged extends AddressEvent {
  final FilterModel? sex;

  LocationSexChanged(this.sex);

  @override
  List<Object?> get props => [sex];
}

class LocationCityChanged extends AddressEvent {
  final FilterModel? city;

  LocationCityChanged(this.city);

  @override
  List<Object?> get props => [city];
}

class LocationDistrictChanged extends AddressEvent {
  final FilterModel? district;

  LocationDistrictChanged(this.district);

  @override
  List<Object?> get props => [district];
}

class LocationWardChanged extends AddressEvent {
  final FilterModel? ward;

  LocationWardChanged(this.ward);

  @override
  List<Object?> get props => [ward];
}

class AddressPaymentAdd extends AddressEvent {
  final Address address;

  AddressPaymentAdd({required this.address});

  @override
  List<Object?> get props => [
        address,
      ];
}
