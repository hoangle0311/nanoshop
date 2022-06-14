part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticationUserRequest extends AuthenticationEvent {
  final TokenParam tokenParam;
  final String userId;

  const AuthenticationUserRequest({
    required this.userId,
    required this.tokenParam,
  });

  @override
  List<Object?> get props => [
        userId,
      ];
}

class AuthenticationCheckLocalRequested extends AuthenticationEvent {
  final TokenParam tokenParam;

  const AuthenticationCheckLocalRequested({
    required this.tokenParam,
  });
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
