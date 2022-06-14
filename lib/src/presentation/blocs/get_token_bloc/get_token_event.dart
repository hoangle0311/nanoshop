part of 'get_token_bloc.dart';

@immutable
abstract class GetTokenEvent {}

class GetToken extends GetTokenEvent {
  final String string;
  final String token;

  GetToken(this.string, this.token);
}
