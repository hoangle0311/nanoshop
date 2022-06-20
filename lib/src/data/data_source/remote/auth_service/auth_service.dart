import 'dart:io';

import 'package:nanoshop/src/core/constant/api/api_path.dart';
import 'package:nanoshop/src/data/models/sign_up_response_model/sign_up_response_model.dart';
import 'package:nanoshop/src/data/models/user/user_login_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../models/default_response_model/default_response_model.dart';

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

  @POST(ApiPath.updateUser)
  @MultiPart()
  Future<HttpResponse<DefaultResponseModel>> updateUser({
    @Header("token") required String token,
    @Part(name: "avatar") File? file,
    @Part(name: "user_id") required String userId,
    @Part(name: "name") String? name,
    @Part(name: "email") String? email,
    @Part(name: "address") String? address,
    // @Body() required Map<String, dynamic> body,
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

  @POST(ApiPath.changePassword)
  Future<HttpResponse<SignUpResponseModel>> changePasswordUser({
    @Header("token") required String token,
    @Body() required Map<String, dynamic> body,
  });
}
