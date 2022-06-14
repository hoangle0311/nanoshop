part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpUsernameChanged extends SignUpEvent {
  final String username;

  const SignUpUsernameChanged(this.username);

  @override
  List<Object> get props => [username];
}

class SignUpPolicyChanged extends SignUpEvent {
  final bool policy;

  const SignUpPolicyChanged(this.policy);

  @override
  List<Object> get props => [policy];
}

class SignUpFullNameChanged extends SignUpEvent {
  final String fullname;

  const SignUpFullNameChanged(this.fullname);

  @override
  List<Object> get props => [fullname];
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  const SignUpPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class SignUpConfirmPasswordChanged extends SignUpEvent {
  final String password;

  const SignUpConfirmPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class SignUpSubmitted extends SignUpEvent {
  final TokenParam tokenParam;

  const SignUpSubmitted({
    required this.tokenParam,
  });
}
