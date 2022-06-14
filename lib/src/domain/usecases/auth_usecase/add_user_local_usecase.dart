import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/entities/user_login/user_login.dart';

import '../../../core/usecases/usecase_with_sync.dart';
import '../../repositories/auth_repository/auth_repository.dart';

class AddUserLocalUsecase extends UseCaseWithFuture<void, UserLogin> {
  final AuthRepository _authRepository;

  AddUserLocalUsecase(
    this._authRepository,
  );

  @override
  Future<void> call(UserLogin params) {
    return _authRepository.addUserLocal(params);
  }
}
