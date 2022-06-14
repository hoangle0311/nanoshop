import '../../../core/usecases/usecase_with_sync.dart';
import '../../repositories/auth_repository/auth_repository.dart';

class GetUserLocalUsecase extends UseCaseWithSync<String?, void> {
  final AuthRepository _authRepository;

  GetUserLocalUsecase(
    this._authRepository,
  );

  @override
  String? call(void params) {
    return _authRepository.getUserIdLocal();
  }
}
