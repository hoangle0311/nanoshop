import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/entities/manufacture/manufacturer.dart';

import '../../../data/responses/manufacturer_response_model/manufacturer_response_model.dart';
import '../../../domain/usecases/product_usecase/get_list_manufacture_usecase.dart';

part 'manufacturer_state.dart';

class ManufacturerCubit extends Cubit<ManufacturerState> {
  final GetListManufacturerUsecase _getListManufacturerUsecase;

  ManufacturerCubit(this._getListManufacturerUsecase)
      : super(
          const ManufacturerState(),
        );

  setManufacture(Manufacturer manufacturer) {
    emit(
      state.copyWith(manufacturer: manufacturer),
    );
  }

  getListManufacturer() async {
    emit(state.copyWith(
      status: ManufacturerStatus.loading,
    ));

    try {
      DataState<ManufacturerResponseModel> dataState =
          await _getListManufacturerUsecase.call(null);

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            listManufacturer: List.of(dataState.data!.data!),
            status: ManufacturerStatus.success,
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            status: ManufacturerStatus.failure,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ManufacturerStatus.failure,
        ),
      );
    }
  }
}
