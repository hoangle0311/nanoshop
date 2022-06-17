part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  final PasswordInput oldPassword;
  final PasswordInput newPassword;
  final ConfirmPasswordInput confirmPassword;
  final FormzStatus status;
  final String message;

  const ChangePasswordState({
    this.message = 'Lỗi',
    this.status = FormzStatus.pure,
    this.oldPassword = const PasswordInput.pure(),
    this.newPassword = const PasswordInput.pure(),
    this.confirmPassword = const ConfirmPasswordInput.pure(),
  });

  ChangePasswordState copyWith({
    FormzStatus? status,
    PasswordInput? newPassword,
    PasswordInput? oldPassword,
    ConfirmPasswordInput? confirmPassword,
    String? message,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      newPassword: newPassword ?? this.newPassword,
      oldPassword: oldPassword ?? this.oldPassword,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        oldPassword,
        newPassword,
        confirmPassword,
        status,
        message,
      ];
}
