import 'package:nanoshop/src/core/params/get_user_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/repositories/auth_repository/auth_repository.dart';

import '../../../data/responses/user/user_login_response_model.dart';


class GetUserUsecase
    extends UseCaseWithFuture<DataState<UserLoginResponseModel>, GetUserParam> {
  final AuthRepository _authRepository;

  GetUserUsecase(
    this._authRepository,
  );

  @override
  Future<DataState<UserLoginResponseModel>> call(
    GetUserParam params,
  ) {
    return _authRepository.getUser(
      params,
    );
  }
}
