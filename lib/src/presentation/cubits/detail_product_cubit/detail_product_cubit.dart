import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nanoshop/src/core/params/detail_product_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/data/models/product_response_model/detail_product_response_model.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';
import 'package:nanoshop/src/domain/usecases/product_usecase/get_detail_product_remote_usecase.dart';

part 'detail_product_state.dart';

class DetailProductCubit extends Cubit<DetailProductState> {
  final GetDetailProductRemoteUsecase _getDetailProductRemoteUsecase;

  DetailProductCubit(
    this._getDetailProductRemoteUsecase,
  ) : super(const DetailProductState());

  void onGetDetail(DetailProductParam param) async {
    emit(
      state.copyWith(status: DetailProductStatus.loading),
    );

    DataState<DetailProductResponseModel> dataState =
        await _getDetailProductRemoteUsecase.call(param);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(
          status: DetailProductStatus.success,
          product: dataState.data!.data,
        ),
      );
    }

    if (dataState is DataFailed) {
      emit(
        state.copyWith(
          status: DetailProductStatus.failure,
        ),
      );
    }
  }
}
