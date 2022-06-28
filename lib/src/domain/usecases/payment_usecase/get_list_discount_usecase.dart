import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/repositories/payment_repository/payment_repository.dart';

import '../../../core/params/voucher_param.dart';
import '../../../data/responses/discount_response_model/discount_response_model.dart';
import '../../../data/responses/list_discount_response_model/list_discount_response_model.dart';

class GetListDiscountUsecase
    extends UseCaseWithFuture<DataState<ListDiscountResponseModel>, String> {
  final PaymentRepository _paymentRepository;

  GetListDiscountUsecase(
      this._paymentRepository,
      );

  @override
  Future<DataState<ListDiscountResponseModel>> call(String token) {
    return _paymentRepository.getListDiscount(token);
  }
}
