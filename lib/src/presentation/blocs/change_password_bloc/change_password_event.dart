part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
}

class OldPasswordChanged extends ChangePasswordEvent {
  final String password;

  const OldPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class NewPasswordChanged extends ChangePasswordEvent {
  final String password;

  const NewPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends ChangePasswordEvent {
  final String password;

  const ConfirmPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class ChangePasswordSubmitted extends ChangePasswordEvent {
  final String userId;

  const ChangePasswordSubmitted({
    required this.userId,
  });

  @override
  List<Object?> get props => [
        userId,
      ];
}
