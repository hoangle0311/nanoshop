part of 'address_bloc.dart';

enum TypeState {
  initialValue,
  typing,
}

class AddressState extends Equatable {
  const AddressState({
    this.typeState = TypeState.typing,
    this.addressPayment = Address.empty,
    this.status = FormzStatus.pure,
    this.name = const FullNameInput.pure(),
    this.address = const FullNameInput.pure(),
    this.phone = const UsernameInput.pure(),
    this.sex = const LocationFormModel.pure(),
    this.city = const LocationFormModel.pure(),
    this.district = const LocationFormModel.pure(),
    this.ward = const LocationFormModel.pure(),
  });

  final Address addressPayment;
  final TypeState typeState;
  final FormzStatus status;
  final UsernameInput phone;
  final FullNameInput name, address;
  final LocationFormModel sex, city, district, ward;

  AddressState copyWith({
    FormzStatus? status,
    UsernameInput? phone,
    FullNameInput? name,
    FullNameInput? address,
    LocationFormModel? sex,
    LocationFormModel? city,
    LocationFormModel? district,
    LocationFormModel? ward,
    Address? addressPayment,
    TypeState? typeState,
  }) {
    return AddressState(
      status: status ?? this.status,
      typeState: typeState ?? this.typeState,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      address: address ?? this.address,
      sex: sex ?? this.sex,
      city: city ?? this.city,
      district: district ?? this.district,
      ward: ward ?? this.ward,
      addressPayment: addressPayment ?? this.addressPayment,
    );
  }

  @override
  List<Object> get props => [
        status,
        phone,
        name,
        address,
        sex,
        city,
        district,
        ward,
        addressPayment,
        typeState,
      ];
}
