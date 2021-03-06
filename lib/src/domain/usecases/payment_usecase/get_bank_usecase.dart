import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/data/models/bank_response_model/bank_response_model.dart';
import 'package:nanoshop/src/domain/repositories/payment_repository/payment_repository.dart';


class GetBankUsecase
    extends UseCaseWithFuture<DataState<BankResponseModel>, String> {
  final PaymentRepository _paymentRepository;

  GetBankUsecase(
      this._paymentRepository,
      );

  @override
  Future<DataState<BankResponseModel>> call(String params) {
    return _paymentRepository.getBank(params);
  }
}
