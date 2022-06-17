import 'package:nanoshop/src/core/constant/api/api_path.dart';
import 'package:nanoshop/src/data/models/bank_response_model/bank_response_model.dart';
import 'package:nanoshop/src/data/models/default_response_model/default_response_model.dart';
import 'package:nanoshop/src/data/models/payment_method_response_model/payment_method_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../models/discount_response_model/discount_response_model.dart';
import '../../../models/order_response_model/order_response_model.dart';
import '../../../models/transport_response_model/transport_response_model.dart';

part 'payment_service.g.dart';

@RestApi()
abstract class PaymentService {
  factory PaymentService(Dio dio, {String baseUrl}) = _PaymentService;

  @POST(ApiPath.getDiscount)
  Future<HttpResponse<DiscountResponseModel>> getDiscount({
    @Header("token") required String token,
    @Part(name: "code") required String code,
  });

  @GET(ApiPath.getTransport)
  Future<HttpResponse<TransportResponseModel>> getTransport({
    @Header("token") required String token,
  });

  @GET(ApiPath.getPayment)
  Future<HttpResponse<PaymentMethodResponseModel>> getPayment({
    @Header("token") required String token,
  });

  @GET(ApiPath.getBank)
  Future<HttpResponse<BankResponseModel>> getBank({
    @Header("token") required String token,
  });

  @POST(ApiPath.checkout)
  Future<HttpResponse<DefaultResponseModel>> checkout({
    @Header("token") required String token,
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiPath.getListOrder)
  Future<HttpResponse<OrderResponseModel>> getListOrder({
    @Header("token") required String token,
    @Body() required Map<String, dynamic> body,
  });
}
