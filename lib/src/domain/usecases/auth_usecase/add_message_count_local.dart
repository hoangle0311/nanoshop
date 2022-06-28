import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/entities/user_login/user_login.dart';

import '../../../core/usecases/usecase_with_sync.dart';
import '../../repositories/auth_repository/auth_repository.dart';

class AddMessageCountLocalUsecase extends UseCaseWithFuture<void, void> {
  final AuthRepository _authRepository;

  AddMessageCountLocalUsecase(
      this._authRepository,
      );

  @override
  Future<void> call(void params) {
    return _authRepository.addCountMessageLocal();
  }
}
