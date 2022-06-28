import 'package:nanoshop/src/core/params/login_user_param.dart';
import 'package:nanoshop/src/domain/entities/user_login/user_login.dart';

import '../../../core/params/change_password_param.dart';
import '../../../core/params/get_user_param.dart';
import '../../../core/params/sign_up_param.dart';
import '../../../core/params/update_user_param.dart';
import '../../../core/resource/data_state.dart';
import '../../../data/responses/default_response_model/default_response_model.dart';
import '../../../data/responses/sign_up_response_model/sign_up_response_model.dart';
import '../../../data/responses/user/user_login_response_model.dart';

abstract class AuthRepository {
  Future<DataState<UserLoginResponseModel>> loginUser(
    LoginUserParam loginUserParam,
  );

  Future<DataState<SignUpResponseModel>> signUpUser(
    SignUpParam signUpParam,
  );

  Future<DataState<UserLoginResponseModel>> getUser(
    GetUserParam param,
  );

  Future<DataState<DefaultResponseModel>> updateUser(
    UpdateUserParam param,
  );

  Future<DataState<DefaultResponseModel>> changePassword(
    ChangePasswordParam param,
  );

  String? getUserIdLocal();

  int getMessageLocal();

  Future<void> addUserLocal(
    UserLogin userLogin,
  );

  Future<void> removeUserLocal();

  Future<void> removeCountMessageLocal();

  Future<void> addCountMessageLocal();
}
