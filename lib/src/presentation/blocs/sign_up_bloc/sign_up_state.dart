part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.status = FormzStatus.pure,
    this.username = const UsernameInput.pure(),
    this.password = const PasswordInput.pure(),
    this.fullname = const FullNameInput.pure(),
    this.confirmPassword = const ConfirmPasswordInput.pure(),
    this.policy = const ConfirmPolicyCheck.pure(),
  });

  final FormzStatus status;
  final UsernameInput username;
  final PasswordInput password;
  final FullNameInput fullname;
  final ConfirmPolicyCheck policy;
  final ConfirmPasswordInput confirmPassword;

  SignUpState copyWith({
    FormzStatus? status,
    UsernameInput? username,
    FullNameInput? fullname,
    ConfirmPasswordInput? confirmPassword,
    PasswordInput? password,
    ConfirmPolicyCheck? policy,
  }) {
    return SignUpState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      fullname: fullname ?? this.fullname,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      policy: policy ?? this.policy,
    );
  }

  @override
  List<Object> get props => [
        status,
        username,
        password,
        fullname,
        confirmPassword,
        policy,
      ];
}
