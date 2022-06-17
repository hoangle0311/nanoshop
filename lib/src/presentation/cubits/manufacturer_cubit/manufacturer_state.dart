part of 'manufacturer_cubit.dart';

enum ManufacturerStatus {
  initial,
  loading,
  success,
  failure,
}

class ManufacturerState extends Equatable {
  final ManufacturerStatus status;
  final List<Manufacturer> listManufacturer;
  final Manufacturer manufacturer;

  const ManufacturerState({
    this.status = ManufacturerStatus.initial,
    this.listManufacturer = const [],
    this.manufacturer = Manufacturer.empty,
  });

  ManufacturerState copyWith({
    ManufacturerStatus? status,
    List<Manufacturer>? listManufacturer,
    Manufacturer? manufacturer,
  }) {
    return ManufacturerState(
      status: status ?? this.status,
      listManufacturer: listManufacturer ?? this.listManufacturer,
      manufacturer: manufacturer ?? this.manufacturer,
    );
  }

  @override
  List<Object?> get props => [
        status,
        listManufacturer,
        manufacturer,
      ];
}
