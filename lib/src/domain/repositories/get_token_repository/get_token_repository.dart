import 'package:nanoshop/src/core/resource/data_state.dart';

import '../../../core/params/token_param.dart';
import '../../../data/responses/token_response_model/token_response_model.dart';

abstract class GetTokenRepository {
  Future<DataState<TokenResponseModel>> getToken(TokenParam param);
}
