import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/core/params/district_param.dart';
import 'package:nanoshop/src/core/utils/log/log.dart';
import 'package:nanoshop/src/domain/usecases/location_usecase/get_list_district_usecase.dart';

import '../../../core/resource/data_state.dart';
import '../../../data/responses/location_response_model/district_response_model.dart';
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


  void onChangeDistrict(FilterModel? district) {
    emit(
      state.copyWith(
        district: district,
      ),
    );
  }

  void onGetListData(DistrictParam param, {FilterModel? initialDistrict}) async {
    emit(
      state.copyWith(
        status: DistrictStatus.loading,
        district: null,
      ),
    );
    DataState<List<District>> dataState =
        await _getListDistrictUsecase.call(param);

    if (dataState is DataSuccess) {
      List<FilterModel> listFilterModel = dataState.data!.map(
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
          district: initialDistrict,
        ),
      );
    }
    if (dataState is DataFailed) {}
  }
}
