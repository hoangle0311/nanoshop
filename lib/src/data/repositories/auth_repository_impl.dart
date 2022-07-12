import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:nanoshop/src/core/params/change_password_param.dart';
import 'package:nanoshop/src/core/params/get_user_param.dart';
import 'package:nanoshop/src/core/params/sign_up_param.dart';
import 'package:nanoshop/src/core/params/update_user_param.dart';
import 'package:nanoshop/src/data/data_source/local/user_service/user_local_service.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';

import 'package:nanoshop/src/data/data_source/remote/auth_service/auth_service.dart';
import 'package:nanoshop/src/domain/entities/user_login/user_login.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/params/login_user_param.dart';
import 'package:nanoshop/src/domain/repositories/auth_repository/auth_repository.dart';

import '../responses/default_response_model/default_response_model.dart';
import '../responses/sign_up_response_model/sign_up_response_model.dart';
import '../responses/user/user_login_response_model.dart';

enum AuthenticationStatus {
  unknown,
  authenticating,
  authenticated,
  unauthenticated,
}

class AuthRepositoryImpl extends AuthRepository {
  final AuthService _authService;
  final UserLocalService _userLocalService;

  AuthRepositoryImpl(
    this._authService,
    this._userLocalService,
  );

  @override
  Future<DataState<UserLoginResponseModel>> loginUser(
    LoginUserParam loginUserParam,
  ) async {
    if (!kReleaseMode) {
      await Future<void>.delayed(
        const Duration(seconds: 1),
      );
    }

    try {
      final HttpResponse<UserLoginResponseModel> response =
          await _authService.loginUser(
        username: loginUserParam.userName,
        password: loginUserParam.password,
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.response.statusMessage,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(
        error: e,
      );
    }
  }

  @override
  Future<DataState<UserLoginResponseModel>> getUser(
    GetUserParam param,
  ) async {
    if (!kReleaseMode) {
      await Future<void>.delayed(
        const Duration(seconds: 1),
      );
    }

    try {
      final HttpResponse response = await _authService.getUser(
        userId: param.userId,
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.response.statusMessage,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(
        error: e,
      );
    }
  }

  @override
  Future<DataState<SignUpResponseModel>> signUpUser(
      SignUpParam signUpParam) async {
    // Log.i(signUpParam.username.toString());
    // Log.i(signUpParam.fullname.toString());
    // Log.i(signUpParam.password.toString());
    try {
      final HttpResponse response = await _authService.signUpUser(
        name: signUpParam.fullname,
        phone: signUpParam.username,
        password: signUpParam.password,
        passwordConfirm: signUpParam.password,
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.response.statusMessage,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(
        error: e,
      );
    }
  }

  @override
  Future<void> addUserLocal(UserLogin userLogin) async {
    await _userLocalService.addUserLocal(userLogin);
  }

  @override
  Future<void> addCountMessageLocal() async {
    await _userLocalService.addCountMessageLocal();
  }

  @override
  String? getUserIdLocal() {
    return _userLocalService.getUserIdLocal();
  }

  @override
  int getMessageLocal() {
    return _userLocalService.getCountMessageLocal();
  }

  @override
  Future<void> removeCountMessageLocal() async {
    return await _userLocalService.removeCountMessageLocal();
  }

  @override
  Future<void> removeUserLocal() async {
    return await _userLocalService.removeUserLocal();
  }

  @override
  Future<DataState<DefaultResponseModel>> changePassword(
      ChangePasswordParam param) async {
    try {
      final HttpResponse response = await _authService.changePasswordUser(
        body: param.toJson(),
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.response.statusMessage,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(
        error: e,
      );
    }
  }

  @override
  Future<DataState<DefaultResponseModel>> updateUser(UpdateUserParam param) async {
    try {
      final HttpResponse response = await _authService.updateUser(
        file: param.file,
        userId: param.userId,
        name: param.userName,
        address: param.address,
        email: param.email,
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.response.statusMessage,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(
        error: e,
      );
    }
  }
}
