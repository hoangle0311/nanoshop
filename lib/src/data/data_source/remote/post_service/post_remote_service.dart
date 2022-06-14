import 'package:nanoshop/src/core/constant/api/api_path.dart';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../domain/entities/post/post.dart';
import '../../../models/post_response_model/post_response_model.dart';

part 'post_remote_service.g.dart';

@RestApi()
abstract class PostRemoteService {
  factory PostRemoteService(Dio dio, {String baseUrl}) = _PostRemoteService;

  // @GET(ApiPath.post)
  @POST(ApiPath.post)
  Future<HttpResponse<PostResponseModel>> getListPost({
    @Header("token") required String token,
    @Part(name: "page") required int page,
    @Part(name: "limit") required int limit,
  });
}
