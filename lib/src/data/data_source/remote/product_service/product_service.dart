import 'package:nanoshop/src/domain/entities/flash_sale/flash_sale.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constant/api/api_path.dart';
import '../../../../core/utils/log/log.dart';
import '../../../../domain/entities/product/product.dart';
import '../../../models/product_response_model/product_response_model.dart';
import '../../../models/user/user_login_response_model.dart';

part 'product_service.g.dart';

@RestApi()
abstract class ProductRemoteService {
  factory ProductRemoteService(Dio dio, {String baseUrl}) =
      _ProductRemoteService;

  @POST(ApiPath.product)
  Future<HttpResponse<ProductResponseModel>> getListProduct({
    @Header("token") required String token,
    @Part(name: "page") int? page = 1,
    @Part(name: "limit") int? limit = 10,
  });

  @GET(ApiPath.flashSale)
  Future<HttpResponse<FlashSale>> getListProductFlashSale();
}
