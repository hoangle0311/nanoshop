import 'package:nanoshop/src/core/usecases/usecase_with_sync.dart';
import 'package:nanoshop/src/domain/entities/address/address.dart';
import 'package:nanoshop/src/domain/repositories/payment_repository/payment_repository.dart';

class GetAddressLocalUsecase extends UseCaseWithSync<Address?, void> {
  final PaymentRepository _paymentRepository;

  GetAddressLocalUsecase(
    this._paymentRepository,
  );

  @override
  Address? call(void params) {
    return _paymentRepository.getAddressLocal();
  }
}
