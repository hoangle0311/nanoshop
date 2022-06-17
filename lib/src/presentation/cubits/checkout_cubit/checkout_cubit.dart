import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nanoshop/src/core/constant/message/message.dart';
import 'package:nanoshop/src/core/params/checkout_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/data/models/default_response_model/default_response_model.dart';
import 'package:nanoshop/src/domain/entities/address/address.dart';
import 'package:nanoshop/src/domain/usecases/payment_usecase/checkout_usecase.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutUsecase _checkoutUsecase;

  CheckoutCubit(this._checkoutUsecase) : super(const CheckoutState());

  onCheckout(CheckoutParam param) async {
    emit(
      state.copyWith(
        status: CheckoutStatus.loading,
      ),
    );

    try {
      DataState<DefaultResponseModel> dataState =
          await _checkoutUsecase.call(param);

      if (dataState is DataSuccess) {
        if (dataState.data!.code == 1) {
          emit(
            state.copyWith(
              status: CheckoutStatus.success,
              message: dataState.data!.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: CheckoutStatus.failure,
              message: dataState.data!.message,
            ),
          );
        }
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: CheckoutStatus.failure,
          message: Message.invalidContent,
        ),
      );
    }
  }
}
