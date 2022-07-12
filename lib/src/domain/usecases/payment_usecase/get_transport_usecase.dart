import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/repositories/payment_repository/payment_repository.dart';

import '../../../data/responses/transport_response_model/transport_response_model.dart';

class GetTransportUsecase
    extends UseCaseWithFuture<DataState<TransportResponseModel>, void> {
  final PaymentRepository _paymentRepository;

  GetTransportUsecase(
    this._paymentRepository,
  );

  @override
  Future<DataState<TransportResponseModel>> call(void params) {
    return _paymentRepository.getTransport();
  }
}
