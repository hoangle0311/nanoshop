import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/core/params/list_flashsale_with_list_product_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';

import '../../../domain/usecases/product_usecase/get_flashsale_with_list_product_usecase.dart';

part 'flash_sale_with_list_product_state.dart';

class FlashSaleWithListProductCubit
    extends Cubit<FlashSaleWithListProductState> {
  final GetFlashSaleWithListProductRemoteUsecase
      _flashSaleWithListProductRemoteUsecase;

  FlashSaleWithListProductCubit(this._flashSaleWithListProductRemoteUsecase)
      : super(
          const FlashSaleWithListProductState(),
        );

  static const limit = 10;
  int _page = 1;

  void onLoadMore({
    required String token,
    required String groupId,
  }) async {
    _page++;
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    try {
      DataState<List<Product>> dataState =
          await _flashSaleWithListProductRemoteUsecase.call(
        ListFlashSaleWithListProductParam(
          token: token,
          groupId: groupId,
          page: _page,
          limit: limit,
        ),
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            status: Status.success,
            products: dataState.data,
            hasMore: dataState.data!.length >= limit,
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            hasMore: false,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          hasMore: false,
        ),
      );
    }
  }

  void onGetListProduct({
    required String token,
    required String groupId,
  }) async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    try {
      DataState<List<Product>> dataState =
          await _flashSaleWithListProductRemoteUsecase.call(
        ListFlashSaleWithListProductParam(
          token: token,
          groupId: groupId,
          page: _page,
          limit: limit,
        ),
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            status: Status.success,
            products: dataState.data,
            hasMore: dataState.data!.length >= limit,
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            status: Status.failure,
            hasMore: false,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.failure,
          hasMore: false,
        ),
      );
    }
  }
}
