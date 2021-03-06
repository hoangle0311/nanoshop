import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nanoshop/src/data/models/bank_response_model/bank_response_model.dart';
import 'package:nanoshop/src/data/models/payment_method_response_model/payment_method_response_model.dart';
import 'package:nanoshop/src/domain/entities/bank/bank.dart';
import 'package:nanoshop/src/domain/entities/payment/payment.dart';
import 'package:nanoshop/src/domain/usecases/payment_usecase/get_payment_usecase.dart';

import '../../../core/params/token_param.dart';
import '../../../core/resource/data_state.dart';
import '../../../domain/usecases/payment_usecase/get_bank_usecase.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final GetPaymentUsecase _getPaymentUsecase;
  final GetBankUsecase _getBankUsecase;

  PaymentCubit(
    this._getPaymentUsecase,
    this._getBankUsecase,
  ) : super(const PaymentState());

  void onChoosePayment(Payment payment, TokenParam tokenParam) async {
    if (payment.id == 12) {
      try {
        DataState<BankResponseModel> dataState =
            await _getBankUsecase.call(tokenParam.token);

        if (dataState is DataSuccess) {
          emit(
            state.copyWith(
              status: PaymentStatus.success,
              payment: payment,
              bank: dataState.data!.data![0],
            ),
          );
        }

        if (dataState is DataFailed) {
          emit(
            state.copyWith(
              status: PaymentStatus.success,
              payment: payment,
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            payment: payment,
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          payment: payment,
          bank: Bank.empty,
        ),
      );
    }
  }

  void onGetListPayment(TokenParam tokenParam) async {
    emit(
      state.copyWith(
        status: PaymentStatus.loading,
      ),
    );
    try {
      DataState<PaymentMethodResponseModel> dataState =
          await _getPaymentUsecase.call(tokenParam.token);

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            status: PaymentStatus.success,
            listPayment: dataState.data!.data!,
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            status: PaymentStatus.failure,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentStatus.failure,
        ),
      );
    }
  }
}
