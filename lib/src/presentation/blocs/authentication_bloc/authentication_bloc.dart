import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/core/params/get_user_param.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/domain/entities/user_login/user_login.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/add_message_count_local.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/get_user_local_usecase.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/get_user_usecase.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/remove_user_local_usecase.dart';

import '../../../chat/firebase/firebase_account.dart';
import '../../../config/environment/app_environment.dart';
import '../../../core/resource/data_state.dart';
import '../../../core/utils/log/log.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../data/responses/user/user_login_response_model.dart';
import '../../../domain/usecases/auth_usecase/get_count_message_local.dart';
import '../../../domain/usecases/auth_usecase/remove_count_message_local_usecase.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetUserUsecase _getUserUsecase;
  final GetUserLocalUsecase _getUserLocalUsecase;
  final RemoveUserLocalUsecase _removeUserLocalUsecase;
  final GetCountMessageLocalUsecase _getCountMessageLocalUsecase;
  final AddMessageCountLocalUsecase _addMessageCountLocalUsecase;
  final RemoveCountMessageLocalUsecase _removeCountMessageLocalUsecase;

  AuthenticationBloc(
    this._getUserUsecase,
    this._getUserLocalUsecase,
    this._removeUserLocalUsecase,
    this._getCountMessageLocalUsecase,
    this._addMessageCountLocalUsecase,
    this._removeCountMessageLocalUsecase,
  ) : super(
          const AuthenticationState.unknown(),
        ) {
    on<AuthenticationUserRequest>(_onAuthenticationStatusChanged);
    on<AuthenticationCheckLocalRequested>(_onAuthenticationCheckLocal);
    on<AuthenticationLogoutRequested>(_onLogout);
    on<AddMessageUserLocal>(_onAddCountMessage);
    on<RemoveCountMessageLocal>(_onRemoveCountMessage);
  }

  @override
  Future<void> close() {
    return super.close();
  }

  _onRemoveCountMessage(
    RemoveCountMessageLocal event,
    emit,
  ) async {
    if (state.user != UserLogin.empty) {
      await _removeCountMessageLocalUsecase.call(null);

      int countMessage = _getCountMessageLocalUsecase.call(null);

      emit(
        state.copyWith(
          countMessage: countMessage,
        ),
      );
    }
  }

  _onAddCountMessage(
    AddMessageUserLocal event,
    emit,
  ) {
    if (state.user != UserLogin.empty) {
      _addMessageCountLocalUsecase.call(null);

      int countMessage = _getCountMessageLocalUsecase.call(null);

      emit(
        state.copyWith(
          countMessage: countMessage,
        ),
      );
    }
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

        try {
          // TODO FIREBASE ACCOUNT
          await FireBaseAccount.createUser(
            id: dataState.data!.data!.type! == '3'
                ? "Admin"
                : dataState.data!.data!.userId,
            name: dataState.data!.data!.type! == '3'
                ? 'Admin'
                : dataState.data!.data!.name,
            avatar: Environment.domain +
                (dataState.data!.data!.avatarPath ?? '') +
                (dataState.data!.data!.avatarName ?? ''),
          );
        } catch (e) {}

        emit(
          AuthenticationState.authenticated(user),
        );

        int countMessage = _getCountMessageLocalUsecase.call(null);

        emit(
          state.copyWith(
            countMessage: countMessage,
          ),
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
  ) async {
    try {
      FireBaseAccount.removeToken(state.user.userId);
    } catch (e) {}

    _removeUserLocalUsecase.call(null);

    emit(
      const AuthenticationState.unknown(),
    );
  }
}
