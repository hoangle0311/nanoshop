import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:nanoshop/src/core/constant/api/api_path.dart';

import '../../../../domain/entities/banner/banner.dart';
import '../../../responses/banner_response_model.dart/banner_response_model.dart';

part 'banner_service.g.dart';

@RestApi()
abstract class BannerService {
  factory BannerService(Dio dio, {String baseUrl}) = _BannerService;

  // @GET(ApiPath.banner)
  @POST(ApiPath.banner)
  Future<HttpResponse<BannerResponseModel>> getBanner({
    @Header("token") required String token,
    @Part(name: "group_id") required String groupId,
    @Part(name: "limit") required String limit,
  });
}
