import 'package:nanoshop/src/core/constant/api/api_path.dart';
import 'package:nanoshop/src/data/models/shop_response_model/shop_response_model.dart';
import 'package:nanoshop/src/data/models/token_response_model/token_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'shop_service.g.dart';

@RestApi()
abstract class ShopService {
  factory ShopService(Dio dio, {String baseUrl}) = _ShopService;

  @POST(ApiPath.getListShop)
  // @DioResponseType(ResponseType.json)
  // Future<HttpResponse<TokenResponseModel>> getToken();
  Future<HttpResponse<ShopResponseModel>> getListShop({
    @Header("token") required String token,
    @Body() required Map<String, dynamic> body,
  });
}
