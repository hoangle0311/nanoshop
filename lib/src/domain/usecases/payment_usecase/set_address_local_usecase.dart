import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/entities/address/address.dart';
import 'package:nanoshop/src/domain/repositories/payment_repository/payment_repository.dart';

class SetAddressLocalUsecase extends UseCaseWithFuture<void, Address> {
  final PaymentRepository _paymentRepository;

  SetAddressLocalUsecase(
    this._paymentRepository,
  );

  @override
  Future<void> call(Address params) async {
    return await _paymentRepository.setAddressLocal(params);
  }
}
