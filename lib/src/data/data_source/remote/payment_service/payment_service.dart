import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:nanoshop/src/core/constant/api/api_path.dart';

import '../../../responses/bank_response_model/bank_response_model.dart';
import '../../../responses/default_response_model/default_response_model.dart';
import '../../../responses/discount_response_model/discount_response_model.dart';
import '../../../responses/list_discount_response_model/list_discount_response_model.dart';
import '../../../responses/order_response_model/order_response_model.dart';
import '../../../responses/payment_method_response_model/payment_method_response_model.dart';
import '../../../responses/transport_response_model/transport_response_model.dart';

part 'payment_service.g.dart';

@RestApi()
abstract class PaymentService {
  factory PaymentService(Dio dio, {String baseUrl}) = _PaymentService;

  @POST(ApiPath.getDiscount)
  Future<HttpResponse<DiscountResponseModel>> getDiscount({
    @Part(name: "code") required String code,
  });

  @POST(ApiPath.getListDiscount)
  Future<HttpResponse<ListDiscountResponseModel>> getListDiscount();

  @GET(ApiPath.getTransport)
  Future<HttpResponse<TransportResponseModel>> getTransport();

  @GET(ApiPath.getPayment)
  Future<HttpResponse<PaymentMethodResponseModel>> getPayment();

  @GET(ApiPath.getBank)
  Future<HttpResponse<BankResponseModel>> getBank();

  @POST(ApiPath.checkout)
  Future<HttpResponse<DefaultResponseModel>> checkout({
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiPath.getListOrder)
  Future<HttpResponse<OrderResponseModel>> getListOrder({
    @Body() required Map<String, dynamic> body,
  });
}
