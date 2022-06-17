import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:nanoshop/src/core/form_model/login/password_input.dart';
import 'package:nanoshop/src/core/form_model/login/username_input.dart';
import 'package:nanoshop/src/core/params/login_user_param.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/data/models/user/user_login_response_model.dart';
import 'package:nanoshop/src/domain/entities/user_login/user_login.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/login_usecase.dart';

import '../../../domain/usecases/auth_usecase/add_user_local_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase _loginUsecase;
  final AddUserLocalUsecase _addUserLocalUsecase;

  LoginBloc(
    this._loginUsecase,
    this._addUserLocalUsecase,
  ) : super(
          const LoginState(),
        ) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  _onUsernameChanged(
    LoginUsernameChanged event,
    emit,
  ) {
    final username = UsernameInput.dirty(
      event.username,
    );

    emit(
      state.copyWith(
        username: username,
        status: Formz.validate(
          [
            state.password,
            username,
          ],
        ),
      ),
    );
  }

  _onPasswordChanged(
    LoginPasswordChanged event,
    emit,
  ) {
    final password = PasswordInput.dirty(
      event.password,
    );

    emit(
      state.copyWith(
        password: password,
        status: Formz.validate(
          [
            state.username,
            password,
          ],
        ),
      ),
    );
  }

  _onLoginSubmitted(
    LoginSubmitted event,
    emit,
  ) async {
    if (state.status.isValidated) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionInProgress,
        ),
      );

      try {
        DataState<UserLoginResponseModel> dataState = await _loginUsecase.call(
          LoginUserParam(
            userName: state.username.value,
            password: state.password.value,
            token: event.tokenParam.token,
          ),
        );

        if (dataState is DataSuccess) {
          await _addUserLocalUsecase.call(
            dataState.data!.data!,
          );

          emit(
            state.copyWith(
              status: FormzStatus.submissionSuccess,
              userLogin: dataState.data!.data,
            ),
          );
        }

        if (dataState is DataFailed) {
          emit(
            state.copyWith(
              status: FormzStatus.submissionFailure,
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
          ),
        );
      }
    }
  }
}
