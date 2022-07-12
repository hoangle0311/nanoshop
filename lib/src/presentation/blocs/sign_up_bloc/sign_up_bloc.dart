import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:nanoshop/src/core/form_model/sign_up/confirm_password_input.dart';
import 'package:nanoshop/src/core/form_model/sign_up/confirm_policy_checkbox.dart';
import 'package:nanoshop/src/core/form_model/sign_up/fullname_input.dart';
import 'package:nanoshop/src/core/params/sign_up_param.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/sign_up_usecase.dart';

import '../../../core/form_model/login/password_input.dart';
import '../../../core/form_model/login/username_input.dart';
import '../../../core/resource/data_state.dart';
import '../../../data/responses/sign_up_response_model/sign_up_response_model.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUsecase _signUpUsecase;

  SignUpBloc(
    this._signUpUsecase,
  ) : super(const SignUpState()) {
    on<SignUpUsernameChanged>(_onUsernameChanged);
    on<SignUpFullNameChanged>(_onFullnameChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignUpPolicyChanged>(_onPolicyChanged);
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  _onSignUpSubmitted(
    SignUpSubmitted event,
    emit,
  ) async {
    if (state.status.isValidated) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionInProgress,
        ),
      );

      DataState<SignUpResponseModel> dataState = await _signUpUsecase.call(
        SignUpParam(
          username: state.username.value,
          password: state.password.value,
          fullname: state.fullname.value,
        ),
      );

      if (dataState is DataSuccess) {
        if (dataState.data!.code == 1) {
          emit(
            state.copyWith(
              message: dataState.data!.message,
              status: FormzStatus.submissionSuccess,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: FormzStatus.submissionFailure,
              message: dataState.data!.message,
            ),
          );
        }
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
          ),
        );
      }
    }
  }

  _onPolicyChanged(SignUpPolicyChanged event, emit) {
    final policy = ConfirmPolicyCheck.dirty(
      event.policy,
    );

    emit(
      state.copyWith(
        policy: policy,
        status: Formz.validate(
          [
            state.password,
            state.confirmPassword,
            state.fullname,
            state.username,
            policy,
          ],
        ),
      ),
    );
  }

  _onUsernameChanged(
    SignUpUsernameChanged event,
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
            state.confirmPassword,
            state.fullname,
            username,
            state.policy,
          ],
        ),
      ),
    );
  }

  _onFullnameChanged(
    SignUpFullNameChanged event,
    emit,
  ) {
    final fullname = FullNameInput.dirty(
      event.fullname,
    );

    emit(
      state.copyWith(
        fullname: fullname,
        status: Formz.validate(
          [
            state.password,
            state.confirmPassword,
            fullname,
            state.username,
            state.policy,
          ],
        ),
      ),
    );
  }

  _onPasswordChanged(
    SignUpPasswordChanged event,
    emit,
  ) {
    final password = PasswordInput.dirty(
      event.password,
    );

    final confirmPassword = ConfirmPasswordInput.dirty(
      password: password.value,
      value: state.confirmPassword.value,
    );

    emit(
      state.copyWith(
        password: password,
        confirmPassword: confirmPassword,
        status: Formz.validate(
          [
            password,
            confirmPassword,
            state.fullname,
            state.username,
            state.policy,
          ],
        ),
      ),
    );
  }

  _onConfirmPasswordChanged(
    SignUpConfirmPasswordChanged event,
    emit,
  ) {
    final confirmPassword = ConfirmPasswordInput.dirty(
      password: state.password.value,
      value: event.password,
    );

    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        status: Formz.validate(
          [
            state.password,
            confirmPassword,
            state.fullname,
            state.username,
            state.policy,
          ],
        ),
      ),
    );
  }
}
