part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticationUserRequest extends AuthenticationEvent {
  final String userId;

  const AuthenticationUserRequest({
    required this.userId,
  });

  @override
  List<Object?> get props => [
        userId,
      ];
}

class AuthenticationCheckLocalRequested extends AuthenticationEvent {

  const AuthenticationCheckLocalRequested();
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class AddMessageUserLocal extends AuthenticationEvent {}

class RemoveCountMessageLocal extends AuthenticationEvent {}
