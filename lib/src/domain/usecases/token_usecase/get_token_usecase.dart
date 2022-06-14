import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/data/models/token_response_model/token_response_model.dart';
import 'package:nanoshop/src/domain/repositories/get_token_repository/get_token_repository.dart';

class GetTokenUsecase
    extends UseCaseWithFuture<DataState<TokenResponseModel>, TokenParam> {
  final GetTokenRepository _getTokenRepository;

  GetTokenUsecase(
    this._getTokenRepository,
  );

  @override
  Future<DataState<TokenResponseModel>> call(TokenParam params) {
    return _getTokenRepository.getToken(params);
  }
}
