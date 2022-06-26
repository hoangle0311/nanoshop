import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constant/api/api_path.dart';
import '../../../responses/category_response_model/category_response_model.dart';

part 'category_service.g.dart';

@RestApi()
abstract class CategoryService {
  factory CategoryService(Dio dio, {String baseUrl}) = _CategoryService;

  // @GET(ApiPath.category)
  @POST(ApiPath.category)
  Future<HttpResponse<CategoryResponseModel>> getListCategory({
    @Part(name: "type") String? type = "product",
    @Header("token") required String token,
  });
}
