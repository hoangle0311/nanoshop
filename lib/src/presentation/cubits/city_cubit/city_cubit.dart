import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/entities/filter_model/filter_model.dart';

import '../../../data/responses/location_response_model/city_response_model.dart';
import '../../../domain/usecases/location_usecase/get_list_city_usecase.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  final GetListCityUsecase _getListCityUsecase;

  CityCubit(
    this._getListCityUsecase,
  ) : super(
          const CityState(),
        );

  void onChangeCity(FilterModel? city) {
    emit(
      state.copyWith(
        city: city,
      ),
    );
  }

  void onGetListData() async {
    emit(
      state.copyWith(
        status: CityStatus.loading,
      ),
    );
    try {
      DataState<CityResponseModel> dataState =
          await _getListCityUsecase.call(null);

      if (dataState is DataSuccess) {
        List<FilterModel> listFilterModel = dataState.data!.data!.map(
          (e) {
            return FilterModel(
              id: e.provinceId!,
              name: e.name!,
            );
          },
        ).toList();

        emit(
          state.copyWith(
            status: CityStatus.success,
            listData: listFilterModel,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: CityStatus.failure,
        ),
      );
    }
  }
}
