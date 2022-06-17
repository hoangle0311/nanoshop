import 'package:nanoshop/src/core/constant/api/api_path.dart';
import 'package:nanoshop/src/data/models/location_response_model/city_response_model.dart';
import 'package:nanoshop/src/data/models/location_response_model/district_response_model.dart';
import 'package:nanoshop/src/data/models/location_response_model/ward_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'location_service.g.dart';

@RestApi()
abstract class LocationService {
  factory LocationService(Dio dio, {String baseUrl}) = _LocationService;

  @POST(ApiPath.getCity)
  Future<HttpResponse<CityResponseModel>> getCity({
    @Header("token") required String token,
  });

  @POST(ApiPath.getDistrict)
  Future<HttpResponse<DistrictResponseModel>> getDistrict({
    @Header("token") required String token,
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiPath.getWard)
  Future<HttpResponse<WardResponseModel>> getWard({
    @Header("token") required String token,
    @Body() required Map<String, dynamic> body,
  });
}
