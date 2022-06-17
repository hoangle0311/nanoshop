import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nanoshop/src/core/params/ward_param.dart';
import 'package:nanoshop/src/data/models/location_response_model/ward_response_model.dart';
import 'package:nanoshop/src/domain/usecases/location_usecase/get_list_ward_usecase.dart';

import '../../../core/resource/data_state.dart';
import '../../../domain/entities/filter_model/filter_model.dart';
import '../../../domain/entities/location/ward.dart';

part 'ward_state.dart';

class WardCubit extends Cubit<WardState> {
  final GetListWardUsecase _getListWardUsecase;

  WardCubit(this._getListWardUsecase)
      : super(
          const WardState(),
        );

  void onChangeDistrict(FilterModel ward) {
    emit(
      state.copyWith(
        ward: ward,
      ),
    );
  }

  void onGetListData(WardParam param) async {
    emit(
      state.copyWith(
        status: WardStatus.loading,
        ward: null,
      ),
    );
    DataState<WardResponseModel> dataState =
        await _getListWardUsecase.call(param);

    if (dataState is DataSuccess) {
      List<FilterModel> listFilterModel = dataState.data!.data!.map(
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
        ),
      );
    }
    if (dataState is DataFailed) {}
  }
}
