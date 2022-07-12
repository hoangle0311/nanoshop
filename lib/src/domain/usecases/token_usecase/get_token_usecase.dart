import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/repositories/get_token_repository/get_token_repository.dart';

import '../../../data/responses/token_response_model/token_response_model.dart';

class GetTokenUsecase
    extends UseCaseWithFuture<DataState<TokenResponseModel>, void> {
  final GetTokenRepository _getTokenRepository;

  GetTokenUsecase(
    this._getTokenRepository,
  );

  @override
  Future<DataState<TokenResponseModel>> call(void params) {
    return _getTokenRepository.getToken();
  }
}
