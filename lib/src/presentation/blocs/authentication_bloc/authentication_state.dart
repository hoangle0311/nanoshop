part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = UserLogin.empty,
    this.countMessage = 0,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticating()
      : this._(
          status: AuthenticationStatus.authenticating,
        );

  const AuthenticationState.authenticated(UserLogin user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final UserLogin user;
  final int countMessage;

  AuthenticationState copyWith({
    int? countMessage,
  }) {
    return AuthenticationState._(
      countMessage: countMessage ?? this.countMessage,
      status: status,
      user: user,
    );
  }

  @override
  List<Object> get props => [
        status,
        user,
        countMessage,
      ];
}
