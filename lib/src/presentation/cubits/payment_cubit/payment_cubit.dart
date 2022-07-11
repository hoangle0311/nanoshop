import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/core/utils/log/log.dart';
import 'package:nanoshop/src/domain/entities/bank/bank.dart';
import 'package:nanoshop/src/domain/entities/payment/payment.dart';
import 'package:nanoshop/src/domain/usecases/payment_usecase/get_payment_usecase.dart';

import '../../../core/params/token_param.dart';
import '../../../core/resource/data_state.dart';
import '../../../data/responses/bank_response_model/bank_response_model.dart';
import '../../../data/responses/payment_method_response_model/payment_method_response_model.dart';
import '../../../domain/usecases/payment_usecase/get_bank_usecase.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final GetPaymentUsecase _getPaymentUsecase;
  final GetBankUsecase _getBankUsecase;

  PaymentCubit(
    this._getPaymentUsecase,
    this._getBankUsecase,
  ) : super(const PaymentState());

  void onChooseBank(Bank bank) {
    emit(
      state.copyWith(
        bank: bank,
      ),
    );
  }

  void onChoosePayment(Payment payment) {
    emit(
      state.copyWith(
        payment: payment,
      ),
    );
  }


  onGetResult({
    Payment? payment,
    Bank? bank,
  }) {
    emit(
      state.copyWith(
        bank: bank,
        payment: payment,
      ),
    );
  }

  // void onChoosePayment(Payment payment, TokenParam tokenParam) async {
  //   if (payment.id == 12) {
  //     try {
  //       DataState<BankResponseModel> dataState =
  //           await _getBankUsecase.call(tokenParam.token);
  //
  //       if (dataState is DataSuccess) {
  //         emit(
  //           state.copyWith(
  //             status: PaymentStatus.success,
  //             payment: payment,
  //             bank: dataState.data!.data![0],
  //             listBank: dataState.data!.data!,
  //           ),
  //         );
  //       }
  //
  //       if (dataState is DataFailed) {
  //         emit(
  //           state.copyWith(
  //             status: PaymentStatus.success,
  //             payment: payment,
  //           ),
  //         );
  //       }
  //     } catch (e) {
  //       emit(
  //         state.copyWith(
  //           payment: payment,
  //         ),
  //       );
  //     }
  //   } else {
  //     emit(
  //       state.copyWith(
  //         payment: payment,
  //         bank: Bank.empty,
  //       ),
  //     );
  //   }
  // }

  void onGetListPayment(TokenParam tokenParam) async {
    emit(
      state.copyWith(
        status: PaymentStatus.loading,
      ),
    );
    try {
      DataState<List<Payment>> dataState =
          await _getPaymentUsecase.call(tokenParam.token);

      List<Bank> _bank = [];

      try {
        DataState<BankResponseModel> bankDataState =
            await _getBankUsecase.call(tokenParam.token);

        _bank.addAll(bankDataState.data!.data!);
      } catch (e) {
        Log.i('Get bank fail');
      }

      List<Payment> _listPayment = dataState.data!.map(
        (e) {
          if (e.id == 12) {
            return e.copyWith(
              listBank: _bank,
            );
          }
          return e;
        },
      ).toList();

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            status: PaymentStatus.success,
            listPayment: _listPayment,
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
