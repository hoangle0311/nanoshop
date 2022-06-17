import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nanoshop/src/core/params/district_param.dart';
import 'package:nanoshop/src/core/utils/log/log.dart';
import 'package:nanoshop/src/data/models/location_response_model/district_response_model.dart';
import 'package:nanoshop/src/domain/usecases/location_usecase/get_list_district_usecase.dart';

import '../../../core/resource/data_state.dart';
import '../../../domain/entities/filter_model/filter_model.dart';
import '../../../domain/entities/location/district.dart';

part 'district_state.dart';

class DistrictCubit extends Cubit<DistrictState> {
  final GetListDistrictUsecase _getListDistrictUsecase;

  DistrictCubit(
    this._getListDistrictUsecase,
  ) : super(
          const DistrictState(),
        );

  void onChangeDistrict(FilterModel district) {
    emit(
      state.copyWith(
        district: district,
      ),
    );
  }

  void onGetListData(DistrictParam param) async {
    emit(
      state.copyWith(
        status: DistrictStatus.loading,
        district: null,
      ),
    );
    DataState<DistrictResponseModel> dataState =
        await _getListDistrictUsecase.call(param);

    if (dataState is DataSuccess) {
      List<FilterModel> listFilterModel = dataState.data!.data!.map(
        (District e) {
          return FilterModel(
            id: e.districtId!,
            name: e.name!,
          );
        },
      ).toList();

      emit(
        state.copyWith(
          status: DistrictStatus.success,
          listData: listFilterModel,
        ),
      );
    }
    if (dataState is DataFailed) {}
  }
}
