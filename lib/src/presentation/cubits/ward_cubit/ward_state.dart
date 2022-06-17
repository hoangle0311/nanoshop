part of 'ward_cubit.dart';

enum WardStatus {
  initial,
  success,
  loading,
  failure,
}

class WardState extends Equatable {
  final FilterModel? ward;
  final List<FilterModel> listData;
  final WardStatus status;

  const WardState({
    this.ward,
    this.listData = const [],
    this.status = WardStatus.initial,
  });

  WardState copyWith({
    FilterModel? ward,
    WardStatus? status,
    List<FilterModel>? listData,
  }) {
    return WardState(
      ward: ward ?? this.ward,
      listData: listData ?? this.listData,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        ward,
        listData,
        status,
      ];
}
