import '../../../core/usecases/usecase_with_sync.dart';
import '../../repositories/auth_repository/auth_repository.dart';

class GetCountMessageLocalUsecase extends UseCaseWithSync<int, void> {
  final AuthRepository _authRepository;

  GetCountMessageLocalUsecase(
    this._authRepository,
  );

  @override
  int call(void params) {
    return _authRepository.getMessageLocal();
  }
}
