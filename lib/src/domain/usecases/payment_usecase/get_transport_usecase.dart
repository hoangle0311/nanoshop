import 'package:nanoshop/src/core/params/category_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/data/models/category_response_model/category_response_model.dart';
import 'package:nanoshop/src/data/models/discount_response_model/discount_response_model.dart';
import 'package:nanoshop/src/data/models/transport_response_model/transport_response_model.dart';
import 'package:nanoshop/src/domain/repositories/payment_repository/payment_repository.dart';

import '../../../core/params/voucher_param.dart';
import '../../repositories/category_repository/category_repository.dart';

class GetTransportUsecase
    extends UseCaseWithFuture<DataState<TransportResponseModel>, String> {
  final PaymentRepository _paymentRepository;

  GetTransportUsecase(
    this._paymentRepository,
  );

  @override
  Future<DataState<TransportResponseModel>> call(String params) {
    return _paymentRepository.getTransport(params);
  }
}
