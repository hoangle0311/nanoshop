import 'package:nanoshop/src/core/params/sign_up_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/data/models/sign_up_response_model/sign_up_response_model.dart';
import 'package:nanoshop/src/domain/repositories/auth_repository/auth_repository.dart';

class SignUpUsecase
    extends UseCaseWithFuture<DataState<SignUpResponseModel>, SignUpParam> {
  final AuthRepository _authRepository;

  SignUpUsecase(
    this._authRepository,
  );

  @override
  Future<DataState<SignUpResponseModel>> call(SignUpParam params) {
    return _authRepository.signUpUser(params);
  }
}
