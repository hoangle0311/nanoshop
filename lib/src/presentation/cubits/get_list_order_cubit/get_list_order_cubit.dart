import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nanoshop/src/core/params/get_list_order_param.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/data/models/order_response_model/order_response_model.dart';
import 'package:nanoshop/src/domain/entities/order/order.dart';

import '../../../core/utils/log/log.dart';
import '../../../domain/usecases/payment_usecase/get_list_order_usecase.dart';

part 'get_list_order_state.dart';

class GetListOrderCubit extends Cubit<GetListOrderState> {
  final GetListOrderUsecase _getListOrderUsecase;

  static const _postPerPage = 10;

  GetListOrderCubit(
    this._getListOrderUsecase,
  ) : super(const GetListOrderState());

  void onLoadMore() async {
    if (state.param != null) {
      emit(
        state.copyWith(status: GetListOrderStatus.loading),
      );
      final params = GetListOrderParam(
        token: state.param!.token,
        orderStatus: state.param!.orderStatus,
        userId: state.param!.userId,
        page: state.param!.page + 1,
        limit: _postPerPage,
      );

      try {
        DataState<OrderResponseModel> dataState =
            await _getListOrderUsecase.call(
          params,
        );

        if (dataState is DataSuccess) {
          List<Order> listOrder = List.of(dataState.data!.data!);

          emit(
            state.copyWith(
              status: GetListOrderStatus.success,
              page: params.page,
              hasMore: listOrder.length >= _postPerPage,
              orders: state.orders
                ..addAll(
                  List.of(listOrder),
                ),
              param: params,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: GetListOrderStatus.success,
              hasMore: false,
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            status: GetListOrderStatus.success,
            hasMore: false,
          ),
        );
      }
    }
  }

  void onGetListData({
    required TokenParam param,
    required int orderStatus,
    required String userId,
  }) async {
    emit(
      state.copyWith(status: GetListOrderStatus.loading),
    );

    final params = GetListOrderParam(
      token: param.token,
      orderStatus: orderStatus,
      userId: userId,
      page: state.page + 1,
      limit: _postPerPage,
    );

    try {
      DataState<OrderResponseModel> dataState = await _getListOrderUsecase.call(
        params,
      );

      if (dataState is DataSuccess) {
        List<Order> listOrder = List.of(dataState.data!.data!);

        emit(
          state.copyWith(
            status: GetListOrderStatus.success,
            page: state.page + 1,
            hasMore: listOrder.length >= _postPerPage,
            orders: listOrder,
            param: params,
          ),
        );
      } else {
        emit(
          state.copyWith(status: GetListOrderStatus.failure),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: GetListOrderStatus.failure),
      );
    }
  }
}
