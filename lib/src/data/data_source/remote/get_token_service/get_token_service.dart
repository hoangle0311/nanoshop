import 'package:nanoshop/src/core/constant/api/api_path.dart';
import 'package:nanoshop/src/data/models/token_response_model/token_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'get_token_service.g.dart';

@RestApi()
abstract class GetTokenService {
  factory GetTokenService(Dio dio, {String baseUrl}) = _GetTokenService;

  @GET(ApiPath.token)
  // @DioResponseType(ResponseType.json)
  // Future<HttpResponse<TokenResponseModel>> getToken();
  Future<HttpResponse<TokenResponseModel>> getToken({
    @Query("string") required String string,
    @Header("token") required String token,
  });
}
