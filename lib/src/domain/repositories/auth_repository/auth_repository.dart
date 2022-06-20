import 'package:nanoshop/src/core/params/login_user_param.dart';
import 'package:nanoshop/src/data/models/default_response_model/default_response_model.dart';
import 'package:nanoshop/src/domain/entities/user_login/user_login.dart';

import '../../../core/params/change_password_param.dart';
import '../../../core/params/get_user_param.dart';
import '../../../core/params/sign_up_param.dart';
import '../../../core/params/update_user_param.dart';
import '../../../core/resource/data_state.dart';
import '../../../data/models/sign_up_response_model/sign_up_response_model.dart';
import '../../../data/models/user/user_login_response_model.dart';

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

  Future<void> addUserLocal(
    UserLogin userLogin,
  );

  Future<void> removeUserLocal();
}
