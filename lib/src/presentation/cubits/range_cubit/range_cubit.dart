import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'range_state.dart';

class RangeCubit extends Cubit<RangeState> {
  RangeCubit() : super(const RangeState());

  void onChangeRangValue(RangeValues rangeValues) {
    emit(
      state.copyWith(rangeValues: rangeValues),
    );
  }
}
