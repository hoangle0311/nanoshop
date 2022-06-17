part of 'sex_cubit.dart';

class SexState extends Equatable {
  final List<FilterModel> listData;
  final FilterModel? sex;

  const SexState({
    this.listData = const [
      FilterModel(id: '1', name: 'Nam'),
      FilterModel(id: '0', name: 'Nữ'),
    ],
    this.sex,
  });

  SexState copyWith({
    FilterModel? sex,
  }) {
    return SexState(
      sex: sex ?? this.sex,
      listData: listData,
    );
  }

  @override
  List<Object?> get props => [
        sex,
        listData,
      ];
}
