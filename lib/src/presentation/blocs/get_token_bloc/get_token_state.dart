part of 'get_token_bloc.dart';

@immutable
abstract class GetTokenState extends Equatable {
  final DioError? error;

  const GetTokenState({
    this.error,
  });
}

class GetTokenLoading extends GetTokenState {
  @override
  List<Object?> get props => [];
}

class GetTokenDone extends GetTokenState {
  const GetTokenDone({
    required Token token,
  });

  @override
  List<Object?> get props => [];
}

class GetTokenFailed extends GetTokenState {
  const GetTokenFailed(DioError? error) : super(error: error);

  @override
  List<Object?> get props => [
        error,
      ];
}
