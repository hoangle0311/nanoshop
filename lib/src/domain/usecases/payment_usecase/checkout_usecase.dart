import 'package:nanoshop/src/core/params/checkout_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/repositories/payment_repository/payment_repository.dart';

import '../../../data/responses/default_response_model/default_response_model.dart';

class CheckoutUsecase
    extends UseCaseWithFuture<DataState<DefaultResponseModel>, CheckoutParam> {
  final PaymentRepository _paymentRepository;

  CheckoutUsecase(
    this._paymentRepository,
  );

  @override
  Future<DataState<DefaultResponseModel>> call(CheckoutParam params) {
    return _paymentRepository.checkOut(params);
  }
}
