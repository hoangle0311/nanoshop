part of 'range_cubit.dart';

@immutable
class RangeState extends Equatable {
  final RangeValues rangeValues;

  const RangeState({
    this.rangeValues = const RangeValues(
      2000000,
      10000000,
    ),
  });

  RangeState copyWith({
    RangeValues? rangeValues,
  }) {
    return RangeState(
      rangeValues: rangeValues ?? this.rangeValues,
    );
  }

  @override
  List<Object?> get props => [
        rangeValues,
      ];
}
