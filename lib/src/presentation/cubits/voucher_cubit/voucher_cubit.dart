import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/core/params/voucher_param.dart';
import 'package:nanoshop/src/domain/usecases/payment_usecase/get_discount_usecase.dart';

import '../../../core/resource/data_state.dart';
import '../../../data/models/discount_response_model/discount_response_model.dart';

part 'voucher_state.dart';

class VoucherCubit extends Cubit<VoucherState> {
  final GetDiscountUsecase _getDiscountUsecase;

  VoucherCubit(
    this._getDiscountUsecase,
  ) : super(
          const VoucherState(),
        );

  void onApplyVoucher({
    required VoucherParam param,
  }) async {
    emit(
      state.copyWith(
        status: VoucherStatus.loading,
      ),
    );

    try {
      DataState<DiscountResponseModel> dataState =
          await _getDiscountUsecase.call(
        param,
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            status: VoucherStatus.success,
            voucherString: param.voucherString,
            message: dataState.data!.message,
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            status: VoucherStatus.failure,
            message: dataState.data!.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: VoucherStatus.failure,
          message: "Voucher không tồn tại",
        ),
      );
    }
  }
}
