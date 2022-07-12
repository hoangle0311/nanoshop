import 'package:nanoshop/src/data/responses/flash_sale_with_list_product_response_model/flash_sale_with_list_product_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constant/api/api_path.dart';
import '../../../responses/add_comment_response/add_comment_response_model.dart';
import '../../../responses/comment_response_model/comment_response_model.dart';
import '../../../responses/flash_sale_response_model/flash_sale_response_model.dart';
import '../../../responses/manufacturer_response_model/manufacturer_response_model.dart';
import '../../../responses/product_response_model/detail_product_response_model.dart';
import '../../../responses/product_response_model/product_response_model.dart';

part 'product_service.g.dart';

@RestApi()
abstract class ProductRemoteService {
  factory ProductRemoteService(Dio dio, {String baseUrl}) =
      _ProductRemoteService;

  @POST(ApiPath.product)
  Future<HttpResponse<ProductResponseModel>> getListProduct({
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiPath.detailProduct)
  Future<HttpResponse<DetailProductResponseModel>> getDetailProduct({
    @Part(name: "id") required int id,
    @Part(name: "type") String? type = "product",
  });

  @POST(ApiPath.addComment)
  Future<HttpResponse<AddCommentResponseModel>> addComment({
    @Body() required Map<String, dynamic> body,
    // @Part(name: "user_id") required String userId,
    // @Part(name: "object_id") required String objectId,
    // @Part(name: "count_rate") double? countRate = 0,
    // @Part(name: "Comment") required Map<String, dynamic> comment,
  });

  @POST(ApiPath.product)
  Future<HttpResponse<ProductResponseModel>> relatedListProduct({
    @Body() required Map<String, dynamic> body,
    // @Part(name: "user_id") required String userId,
    // @Part(name: "object_id") required String objectId,
    // @Part(name: "count_rate") double? countRate = 0,
    // @Part(name: "Comment") required Map<String, dynamic> comment,
  });

  @POST(ApiPath.getComment)
  Future<HttpResponse<CommentResponseModel>> getListComment({
    @Body() required Map<String, dynamic> body,
    // @Part(name: "user_id") required String userId,
    // @Part(name: "object_id") required String objectId,
    // @Part(name: "count_rate") double? countRate = 0,
    // @Part(name: "Comment") required Map<String, dynamic> comment,
  });

  @GET(ApiPath.flashSale)
  Future<HttpResponse<FlashSaleResponseModel>> getListFlashSale();

  @POST(ApiPath.flashSaleWithListProduct)
  Future<HttpResponse<FlashSaleWithListProductResponseModel>> getFlashSaleWithListProduct({
    @Body() required Map<String, dynamic> body,
  });

  @GET(ApiPath.getManufacturer)
  Future<HttpResponse<ManufacturerResponseModel>> getListManufacturer();
}
