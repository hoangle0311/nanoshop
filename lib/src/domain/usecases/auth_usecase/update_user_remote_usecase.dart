import 'package:nanoshop/src/core/params/update_user_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/data/models/default_response_model/default_response_model.dart';
import 'package:nanoshop/src/domain/entities/user_login/user_login.dart';

import '../../../core/usecases/usecase_with_sync.dart';
import '../../repositories/auth_repository/auth_repository.dart';

class UpdateUserRemoteUsecase extends UseCaseWithFuture<DataState<DefaultResponseModel>, UpdateUserParam> {
  final AuthRepository _authRepository;

  UpdateUserRemoteUsecase(
      this._authRepository,
      );

  @override
  Future<DataState<DefaultResponseModel>> call(UpdateUserParam params) {
    return _authRepository.updateUser(params);
  }
}
