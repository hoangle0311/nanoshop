import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/data/models/token_response_model/token_response_model.dart';

import '../../../core/params/token_param.dart';

abstract class GetTokenRepository {
  Future<DataState<TokenResponseModel>> getToken(TokenParam param);
}
