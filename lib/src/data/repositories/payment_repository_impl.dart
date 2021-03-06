import 'dart:io';

import 'package:nanoshop/src/core/params/checkout_param.dart';
import 'package:nanoshop/src/core/params/get_list_order_param.dart';
import 'package:nanoshop/src/data/data_source/remote/payment_service/payment_service.dart';
import 'package:nanoshop/src/data/models/bank_response_model/bank_response_model.dart';
import 'package:nanoshop/src/data/models/default_response_model/default_response_model.dart';
import 'package:nanoshop/src/data/models/order_response_model/order_response_model.dart';
import 'package:nanoshop/src/data/models/transport_response_model/transport_response_model.dart';
import 'package:nanoshop/src/domain/repositories/payment_repository/payment_repository.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';

import 'package:nanoshop/src/core/resource/data_state.dart';

import '../../core/params/voucher_param.dart';
import '../../core/utils/log/log.dart';
import '../models/discount_response_model/discount_response_model.dart';
import '../models/payment_method_response_model/payment_method_response_model.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentService _paymentService;

  PaymentRepositoryImpl(
    this._paymentService,
  );

  @override
  Future<DataState<DiscountResponseModel>> getDiscount(
      VoucherParam param) async {
    try {
      final HttpResponse<DiscountResponseModel> response =
          await _paymentService.getDiscount(
        token: param.token,
        code: param.voucherString,
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.response.statusMessage,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(
        error: e,
      );
    }
  }

  @override
  Future<DataState<TransportResponseModel>> getTransport(String param) async {
    try {
      final HttpResponse<TransportResponseModel> response =
          await _paymentService.getTransport(
        token: param,
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.response.statusMessage,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(
        error: e,
      );
    }
  }

  @override
  Future<DataState<PaymentMethodResponseModel>> getPayment(String param) async {
    try {
      final HttpResponse<PaymentMethodResponseModel> response =
          await _paymentService.getPayment(
        token: param,
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.response.statusMessage,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(
        error: e,
      );
    }
  }

  @override
  Future<DataState<BankResponseModel>> getBank(String param) async {
    try {
      final HttpResponse<BankResponseModel> response =
          await _paymentService.getBank(
        token: param,
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.response.statusMessage,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(
        error: e,
      );
    }
  }

  @override
  Future<DataState<DefaultResponseModel>> checkOut(CheckoutParam param) async {
    try {
      final HttpResponse<DefaultResponseModel> response =
          await _paymentService.checkout(
        token: param.token,
        body: param.toJson(),
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.response.statusMessage,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(
        error: e,
      );
    }
  }

  @override
  Future<DataState<OrderResponseModel>> getListOrder(GetListOrderParam param) async {
    try {
      final HttpResponse<OrderResponseModel> response =
          await _paymentService.getListOrder(
        token: param.token,
        body: param.toJson(),
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.response.statusMessage,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(
        error: e,
      );
    }
  }
}
