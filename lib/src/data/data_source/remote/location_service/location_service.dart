import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:nanoshop/src/core/constant/api/api_path.dart';

import '../../../responses/location_response_model/city_response_model.dart';
import '../../../responses/location_response_model/district_response_model.dart';
import '../../../responses/location_response_model/ward_response_model.dart';

part 'location_service.g.dart';

@RestApi()
abstract class LocationService {
  factory LocationService(Dio dio, {String baseUrl}) = _LocationService;

  @POST(ApiPath.getCity)
  Future<HttpResponse<CityResponseModel>> getCity();

  @POST(ApiPath.getDistrict)
  Future<HttpResponse<DistrictResponseModel>> getDistrict({
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiPath.getWard)
  Future<HttpResponse<WardResponseModel>> getWard({
    @Body() required Map<String, dynamic> body,
  });
}
