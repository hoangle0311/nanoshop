part of 'district_cubit.dart';

enum DistrictStatus {
  initial,
  success,
  loading,
  failure,
}

class DistrictState extends Equatable {
  final FilterModel? district;
  final List<FilterModel> listData;
  final DistrictStatus status;

  const DistrictState({
    this.district,
    this.listData = const [],
    this.status = DistrictStatus.initial,
  });

  DistrictState copyWith({
    FilterModel? district,
    DistrictStatus? status,
    List<FilterModel>? listData,
  }) {
    return DistrictState(
      district: district,
      listData: listData ?? this.listData,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        district,
        listData,
        status,
      ];
}
