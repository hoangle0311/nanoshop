import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/domain/entities/filter_model/filter_model.dart';

part 'sex_state.dart';

class SexCubit extends Cubit<SexState> {
  SexCubit()
      : super(
          const SexState(),
        );

  void onChangeSex(FilterModel? sex) {
    emit(
      state.copyWith(
        sex: sex,
      ),
    );
  }
}
