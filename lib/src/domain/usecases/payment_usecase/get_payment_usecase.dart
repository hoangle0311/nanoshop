import 'package:nanoshop/src/core/params/category_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/data/models/category_response_model/category_response_model.dart';
import 'package:nanoshop/src/data/models/discount_response_model/discount_response_model.dart';
import 'package:nanoshop/src/data/models/payment_method_response_model/payment_method_response_model.dart';
import 'package:nanoshop/src/domain/repositories/payment_repository/payment_repository.dart';

import '../../../core/params/voucher_param.dart';
import '../../repositories/category_repository/category_repository.dart';

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
