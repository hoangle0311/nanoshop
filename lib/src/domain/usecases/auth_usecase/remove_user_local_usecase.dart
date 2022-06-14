import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';

import '../../../core/usecases/usecase_with_sync.dart';
import '../../repositories/auth_repository/auth_repository.dart';

class RemoveUserLocalUsecase extends UseCaseWithFuture<void, void> {
  final AuthRepository _authRepository;

  RemoveUserLocalUsecase(
    this._authRepository,
  );

  @override
  Future<void> call(void params) {
    return _authRepository.removeUserLocal();
  }
}
