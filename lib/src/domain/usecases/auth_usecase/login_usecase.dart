import 'package:nanoshop/src/core/params/login_user_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/repositories/auth_repository/auth_repository.dart';

import '../../../data/responses/user/user_login_response_model.dart';


class LoginUsecase
    extends UseCaseWithFuture<DataState<UserLoginResponseModel>, LoginUserParam> {
  final AuthRepository _authRepository;

  LoginUsecase(
    this._authRepository,
  );

  @override
  Future<DataState<UserLoginResponseModel>> call(LoginUserParam params) {
    return _authRepository.loginUser(params);
  }
}
