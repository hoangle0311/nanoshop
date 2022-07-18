import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:nanoshop/src/core/params/ward_param.dart';
import 'package:nanoshop/src/domain/usecases/location_usecase/get_list_ward_usecase.dart';

import '../../../core/resource/data_state.dart';
import '../../../data/responses/location_response_model/ward_response_model.dart';
import '../../../domain/entities/filter_model/filter_model.dart';
import '../../../domain/entities/location/ward.dart';

part 'ward_state.dart';

class WardCubit extends Cubit<WardState> {
  final GetListWardUsecase _getListWardUsecase;

  WardCubit(this._getListWardUsecase)
      : super(
          const WardState(),
        );

  void onChangeWard(FilterModel ward) {
    emit(
      state.copyWith(
        ward: ward,
      ),
    );
  }

  void onGetListData(
    WardParam param, {
    FilterModel? initialValue,
  }) async {
    emit(
      state.copyWith(
        status: WardStatus.loading,
        ward: null,
      ),
    );
    DataState<List<Ward>> dataState =
        await _getListWardUsecase.call(param);

    if (dataState is DataSuccess) {
      List<FilterModel> listFilterModel = dataState.data!.map(
        (Ward e) {
          return FilterModel(
            id: e.wardId!,
            name: e.name!,
          );
        },
      ).toList();

      emit(
        state.copyWith(
          status: WardStatus.success,
          listData: listFilterModel,
          ward: initialValue,
        ),
      );
    }
    if (dataState is DataFailed) {}
  }
}
