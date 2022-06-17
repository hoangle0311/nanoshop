import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/data/models/bank_response_model/bank_response_model.dart';
import 'package:nanoshop/src/data/models/default_response_model/default_response_model.dart';
import 'package:nanoshop/src/data/models/discount_response_model/discount_response_model.dart';
import 'package:nanoshop/src/data/models/order_response_model/order_response_model.dart';
import 'package:nanoshop/src/data/models/payment_method_response_model/payment_method_response_model.dart';

import '../../../core/params/checkout_param.dart';
import '../../../core/params/get_list_order_param.dart';
import '../../../core/params/voucher_param.dart';
import '../../../data/models/transport_response_model/transport_response_model.dart';

abstract class PaymentRepository {
  Future<DataState<DiscountResponseModel>> getDiscount(VoucherParam param);

  Future<DataState<TransportResponseModel>> getTransport(String param);
  Future<DataState<PaymentMethodResponseModel>> getPayment(String param);
  Future<DataState<BankResponseModel>> getBank(String param);
  Future<DataState<DefaultResponseModel>> checkOut(CheckoutParam param);
  Future<DataState<OrderResponseModel>> getListOrder(GetListOrderParam param);
}
