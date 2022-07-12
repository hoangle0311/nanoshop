import 'dart:io';

import 'package:nanoshop/src/data/models/payment/payment_model.dart';
import 'package:nanoshop/src/domain/entities/address/address.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';

import 'package:nanoshop/src/core/params/checkout_param.dart';
import 'package:nanoshop/src/core/params/get_list_order_param.dart';
import 'package:nanoshop/src/data/data_source/remote/payment_service/payment_service.dart';
import 'package:nanoshop/src/domain/repositories/payment_repository/payment_repository.dart';

import 'package:nanoshop/src/core/resource/data_state.dart';

import '../../core/params/voucher_param.dart';
import '../data_source/local/payment_local_service/payment_local_service.dart';
import '../responses/bank_response_model/bank_response_model.dart';
import '../responses/default_response_model/default_response_model.dart';
import '../responses/discount_response_model/discount_response_model.dart';
import '../responses/list_discount_response_model/list_discount_response_model.dart';
import '../responses/order_response_model/order_response_model.dart';
import '../responses/payment_method_response_model/payment_method_response_model.dart';
import '../responses/transport_response_model/transport_response_model.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentService _paymentService;
  final PaymentLocalService _paymentLocalService;

  PaymentRepositoryImpl(
    this._paymentService,
    this._paymentLocalService,
  );

  @override
  Future<DataState<DiscountResponseModel>> getDiscount(
      VoucherParam param) async {
    try {
      final HttpResponse<DiscountResponseModel> response =
          await _paymentService.getDiscount(
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
  Future<DataState<ListDiscountResponseModel>> getListDiscount() async {
    try {
      final HttpResponse<ListDiscountResponseModel> response =
          await _paymentService.getListDiscount();

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
  Future<DataState<TransportResponseModel>> getTransport() async {
    try {
      final HttpResponse<TransportResponseModel> response =
          await _paymentService.getTransport();

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
  Future<DataState<List<PaymentModel>>> getPayment() async {
    try {
      final HttpResponse<PaymentMethodResponseModel> response =
          await _paymentService.getPayment(
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data.data!);
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
  Future<DataState<BankResponseModel>> getBank() async {
    try {
      final HttpResponse<BankResponseModel> response =
          await _paymentService.getBank(
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
  Future<DataState<OrderResponseModel>> getListOrder(
      GetListOrderParam param) async {
    try {
      final HttpResponse<OrderResponseModel> response =
          await _paymentService.getListOrder(
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
  Address? getAddressLocal() {
    return _paymentLocalService.getAddressLocal();
  }

  @override
  Future<void> setAddressLocal(Address address) async {
    await _paymentLocalService.setAddressLocal(address);
  }
}
