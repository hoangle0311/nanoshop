import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/repositories/payment_repository/payment_repository.dart';

import '../../../data/responses/payment_method_response_model/payment_method_response_model.dart';


class GetPaymentUsecase
    extends UseCaseWithFuture<DataState<PaymentMethodResponseModel>, String> {
  final PaymentRepository _paymentRepository;

  GetPaymentUsecase(
      this._paymentRepository,
      );

  @override
  Future<DataState<PaymentMethodResponseModel>> call(String params) {
    return _paymentRepository.getPayment(params);
  }
}
