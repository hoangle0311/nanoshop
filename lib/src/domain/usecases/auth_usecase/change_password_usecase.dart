import 'package:nanoshop/src/core/params/change_password_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';

import '../../../data/responses/default_response_model/default_response_model.dart';
import '../../repositories/auth_repository/auth_repository.dart';

class ChangePasswordUsecase extends UseCaseWithFuture<DataState<DefaultResponseModel>, ChangePasswordParam> {
  final AuthRepository _authRepository;

  ChangePasswordUsecase(
      this._authRepository,
      );

  @override
  Future<DataState<DefaultResponseModel>> call(ChangePasswordParam params) {
    return _authRepository.changePassword(params);
  }
}
