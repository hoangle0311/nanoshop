import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:nanoshop/src/core/params/change_password_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/utils/log/log.dart';

import '../../../core/form_model/login/password_input.dart';
import '../../../core/form_model/sign_up/confirm_password_input.dart';
import '../../../data/responses/default_response_model/default_response_model.dart';
import '../../../domain/usecases/auth_usecase/change_password_usecase.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUsecase _changePasswordUsecase;

  ChangePasswordBloc(this._changePasswordUsecase)
      : super(
          const ChangePasswordState(),
        ) {
    on<OldPasswordChanged>(_onOldPasswordChanged);
    on<NewPasswordChanged>(_onNewPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<ChangePasswordSubmitted>(_onChangePasswordSubmitted);
  }

  _onChangePasswordSubmitted(
    ChangePasswordSubmitted event,
    emit,
  ) async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));

    try {
      DataState<DefaultResponseModel> dataState =
          await _changePasswordUsecase.call(
        ChangePasswordParam(
          userId: event.userId,
          oldPassword: state.oldPassword.value,
          password: state.newPassword.value,
          passwordConfirm: state.confirmPassword.value,
        ),
      );

      if (dataState is DataSuccess) {
        Log.i(dataState.data!.code.toString());
        if (dataState.data!.code == 1) {
          emit(
            state.copyWith(
              message: dataState.data!.message,
              status: FormzStatus.submissionSuccess,
            ),
          );
        } else {
          emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            message: dataState.data!.message,
          ));
        }
      } else {
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
      ));
    }
  }

  _onOldPasswordChanged(
    OldPasswordChanged event,
    emit,
  ) {
    final oldPassword = PasswordInput.dirty(
      event.password,
    );

    emit(
      state.copyWith(
        oldPassword: oldPassword,
        status: Formz.validate(
          [
            oldPassword,
            state.newPassword,
            state.confirmPassword,
          ],
        ),
      ),
    );
  }

  _onNewPasswordChanged(
    NewPasswordChanged event,
    emit,
  ) {
    final newPassword = PasswordInput.dirty(
      event.password,
    );

    final confirmPassword = ConfirmPasswordInput.dirty(
      password: newPassword.value,
      value: state.confirmPassword.value,
    );

    emit(
      state.copyWith(
        newPassword: newPassword,
        confirmPassword: confirmPassword,
        status: Formz.validate(
          [
            state.oldPassword,
            newPassword,
            confirmPassword,
          ],
        ),
      ),
    );
  }

  _onConfirmPasswordChanged(
    ConfirmPasswordChanged event,
    emit,
  ) {
    final confirmPassword = ConfirmPasswordInput.dirty(
      password: state.newPassword.value,
      value: event.password,
    );

    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        status: Formz.validate(
          [
            state.oldPassword,
            state.newPassword,
            confirmPassword,
          ],
        ),
      ),
    );
  }
}
