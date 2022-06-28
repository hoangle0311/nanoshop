import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';

import '../../../data/responses/list_discount_response_model/list_discount_response_model.dart';
import '../../../domain/entities/discount/discount_data.dart';
import '../../../domain/usecases/payment_usecase/get_list_discount_usecase.dart';

part 'get_list_coupon_state.dart';

class GetListCouponCubit extends Cubit<GetListCouponState> {
  final GetListDiscountUsecase _getListDiscountUsecase;

  GetListCouponCubit(this._getListDiscountUsecase)
      : super(
          const GetListCouponState(),
        );

  void onGetListVoucher(
    TokenParam tokenParam,
  ) async {
    emit(
      state.copyWith(
        status: GetListCouponStatus.loading,
      ),
    );

    try {
      DataState<ListDiscountResponseModel> dataState =
          await _getListDiscountUsecase.call(
        tokenParam.token,
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            status: GetListCouponStatus.success,
            listVoucher: List.of(dataState.data!.data!),
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: GetListCouponStatus.failure,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: GetListCouponStatus.failure,
        ),
      );
    }
  }
}
