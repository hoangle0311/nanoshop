import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/entities/address/address.dart';

import '../../../core/params/checkout_param.dart';
import '../../../core/params/get_list_order_param.dart';
import '../../../core/params/voucher_param.dart';
import '../../../data/responses/bank_response_model/bank_response_model.dart';
import '../../../data/responses/default_response_model/default_response_model.dart';
import '../../../data/responses/discount_response_model/discount_response_model.dart';
import '../../../data/responses/list_discount_response_model/list_discount_response_model.dart';
import '../../../data/responses/order_response_model/order_response_model.dart';
import '../../../data/responses/payment_method_response_model/payment_method_response_model.dart';
import '../../../data/responses/transport_response_model/transport_response_model.dart';
import '../../entities/payment/payment.dart';

abstract class PaymentRepository {
  Future<DataState<DiscountResponseModel>> getDiscount(VoucherParam param);

  Future<DataState<ListDiscountResponseModel>> getListDiscount();

  Future<DataState<TransportResponseModel>> getTransport();

  Future<DataState<List<Payment>>> getPayment();

  Future<DataState<BankResponseModel>> getBank();

  Future<DataState<DefaultResponseModel>> checkOut(CheckoutParam param);

  Future<DataState<OrderResponseModel>> getListOrder(GetListOrderParam param);

  Address? getAddressLocal();

  Future<void> setAddressLocal(Address address);
}
