import 'package:nanoshop/src/core/constant/api/api_path.dart';
import 'package:nanoshop/src/data/models/sign_up_response_model/sign_up_response_model.dart';
import 'package:nanoshop/src/data/models/user/user_login_response_model.dart';
import 'package:nanoshop/src/domain/entities/user_login/user_login.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  // @GET(ApiPath.login)
  @POST(ApiPath.login)
  Future<HttpResponse<UserLoginResponseModel>> loginUser({
    @Header("token") required String token,
    @Part(name: "username") required String username,
    @Part(name: "password") required String password,
  });

  // @GET(ApiPath.getUser)
  @POST(ApiPath.getUser)
  Future<HttpResponse<UserLoginResponseModel>> getUser({
    @Header("token") required String token,
    @Part(name: "user_id") required String userId,
  });

  // @GET(ApiPath.signUp)
  @POST(ApiPath.signUp)
  Future<HttpResponse<SignUpResponseModel>> signUpUser({
    @Header("token") required String token,
    @Part(name: "name") required String name,
    @Part(name: "phone") required String phone,
    @Part(name: "password") required String password,
    @Part(name: "passwordConfirm") required String passwordConfirm,
  });
}
