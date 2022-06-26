import 'package:nanoshop/src/core/params/get_list_order_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/repositories/payment_repository/payment_repository.dart';

import '../../../data/responses/order_response_model/order_response_model.dart';

class GetListOrderUsecase
    extends UseCaseWithFuture<DataState<OrderResponseModel>, GetListOrderParam> {
  final PaymentRepository _paymentRepository;

  GetListOrderUsecase(
      this._paymentRepository,
      );

  @override
  Future<DataState<OrderResponseModel>> call(GetListOrderParam params) {
    return _paymentRepository.getListOrder(params);
  }
}
