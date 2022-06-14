part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.userLogin = UserLogin.empty,
    this.username = const UsernameInput.pure(),
    this.password = const PasswordInput.pure(),
  });

  final FormzStatus status;
  final UsernameInput username;
  final PasswordInput password;
  final UserLogin userLogin;

  LoginState copyWith({
    FormzStatus? status,
    UsernameInput? username,
    PasswordInput? password,
    UserLogin? userLogin,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      userLogin: userLogin ?? this.userLogin,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}
