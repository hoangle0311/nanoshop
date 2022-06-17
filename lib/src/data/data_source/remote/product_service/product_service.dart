import 'dart:convert';

import 'package:nanoshop/src/data/models/comment_response_model/comment_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constant/api/api_path.dart';
import '../../../../core/utils/log/log.dart';
import '../../../models/add_comment_response/add_comment_response_model.dart';
import '../../../models/flash_sale_response_model/flash_sale_response_model.dart';
import '../../../models/product_response_model/detail_product_response_model.dart';
import '../../../models/product_response_model/product_response_model.dart';

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

  @POST(ApiPath.detailProduct)
  Future<HttpResponse<DetailProductResponseModel>> getDetailProduct({
    @Header("token") required String token,
    @Part(name: "id") required int id,
    @Part(name: "type") String? type = "product",
  });

  @POST(ApiPath.addComment)
  Future<HttpResponse<AddCommentResponseModel>> addComment({
    @Header("token") required String token,
    @Body() required Map<String, dynamic> body,
    // @Part(name: "user_id") required String userId,
    // @Part(name: "object_id") required String objectId,
    // @Part(name: "count_rate") double? countRate = 0,
    // @Part(name: "Comment") required Map<String, dynamic> comment,
  });

  @POST(ApiPath.product)
  Future<HttpResponse<ProductResponseModel>> relatedListProduct({
    @Header("token") required String token,
    @Body() required Map<String, dynamic> body,
    // @Part(name: "user_id") required String userId,
    // @Part(name: "object_id") required String objectId,
    // @Part(name: "count_rate") double? countRate = 0,
    // @Part(name: "Comment") required Map<String, dynamic> comment,
  });

  @POST(ApiPath.getComment)
  Future<HttpResponse<CommentResponseModel>> getListComment({
    @Header("token") required String token,
    @Body() required Map<String, dynamic> body,
    // @Part(name: "user_id") required String userId,
    // @Part(name: "object_id") required String objectId,
    // @Part(name: "count_rate") double? countRate = 0,
    // @Part(name: "Comment") required Map<String, dynamic> comment,
  });

  @GET(ApiPath.flashSale)
  Future<HttpResponse<FlashSaleResponseModel>> getListProductFlashSale({
    @Header("token") required String token,
  });
}
