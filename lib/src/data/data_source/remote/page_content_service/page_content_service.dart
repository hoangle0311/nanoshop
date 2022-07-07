import 'package:nanoshop/src/data/responses/page_content_response/page_content_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:nanoshop/src/core/constant/api/api_path.dart';

part 'page_content_service.g.dart';

@RestApi()
abstract class PageContentService {
  factory PageContentService(Dio dio, {String baseUrl}) = _PageContentService;

  // @GET(ApiPath.banner)
  @POST(ApiPath.pageContent)
  Future<HttpResponse<PageContentResponse>> getPageContent({
    @Header("token") required String token,
    @Body() required Map<String, dynamic> body,
  });
}
