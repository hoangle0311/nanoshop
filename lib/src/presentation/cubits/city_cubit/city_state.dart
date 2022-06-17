part of 'city_cubit.dart';

enum CityStatus {
  initial,
  success,
  loading,
  failure,
}

class CityState extends Equatable {
  final FilterModel? city;
  final List<FilterModel> listData;
  final CityStatus status;

  const CityState({
    this.city,
    this.listData = const [],
    this.status = CityStatus.initial,
  });

  CityState copyWith({
    FilterModel? city,
    CityStatus? status,
    List<FilterModel>? listData,
  }) {
    return CityState(
      city: city ?? this.city,
      listData: listData ?? this.listData,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        city,
        listData,
        status,
      ];
}
