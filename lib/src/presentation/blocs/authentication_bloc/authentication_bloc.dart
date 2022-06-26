import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/core/params/get_user_param.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/domain/entities/user_login/user_login.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/get_user_local_usecase.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/get_user_usecase.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/remove_user_local_usecase.dart';

import '../../../core/resource/data_state.dart';
import '../../../core/utils/log/log.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../data/responses/user/user_login_response_model.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetUserUsecase _getUserUsecase;
  final GetUserLocalUsecase _getUserLocalUsecase;
  final RemoveUserLocalUsecase _removeUserLocalUsecase;

  AuthenticationBloc(
    this._getUserUsecase,
    this._getUserLocalUsecase, this._removeUserLocalUsecase,
  ) : super(
          const AuthenticationState.unknown(),
        ) {
    on<AuthenticationUserRequest>(_onAuthenticationStatusChanged);
    on<AuthenticationCheckLocalRequested>(_onAuthenticationCheckLocal);
    on<AuthenticationLogoutRequested>(_onLogout);
  }

  @override
  Future<void> close() {
    return super.close();
  }

  _onAuthenticationCheckLocal(
    AuthenticationCheckLocalRequested event,
    emit,
  ) async {
    emit(
      const AuthenticationState.authenticating(),
    );

    var userId = _getUserLocalUsecase.call(null);

    if (userId == null) {
      return;
    }

    emit(
      AuthenticationState.authenticated(
        UserLogin(
          userId: userId,
        ),
      ),
    );
    try {
      emit(
       const AuthenticationState.authenticating(),
      );

      DataState<UserLoginResponseModel> dataState = await _getUserUsecase.call(
        GetUserParam(
          userId: userId,
          token: event.tokenParam.token,
        ),
      );

      if (dataState is DataSuccess) {
        UserLogin user = dataState.data!.data!;

        emit(
          AuthenticationState.authenticated(user),
        );
      }

      if (dataState is DataFailed) {
        emit(
          const AuthenticationState.unauthenticated(),
        );
      }
    } catch (e) {
      emit(
        const AuthenticationState.unauthenticated(),
      );
    }
  }

  _onAuthenticationStatusChanged(
    AuthenticationUserRequest event,
    emit,
  ) async {
    var userId = _getUserLocalUsecase.call(null);

    if (userId == null) {
      return;
    }

    emit(
      const AuthenticationState.authenticating(),
    );

    DataState<UserLoginResponseModel> dataState = await _getUserUsecase.call(
      GetUserParam(
        userId: event.userId,
        token: event.tokenParam.token,
      ),
    );

    if (dataState is DataSuccess) {
      UserLogin user = dataState.data!.data!;

      emit(
        AuthenticationState.authenticated(user),
      );
    }

    if (dataState is DataFailed) {
      emit(
        const AuthenticationState.unauthenticated(),
      );
    }
  }

  _onLogout(
    AuthenticationLogoutRequested event,
    emit,
  ) {
    _removeUserLocalUsecase.call(null);
    emit(
      const AuthenticationState.unknown(),
    );
  }
}
