part of 'voucher_cubit.dart';

enum VoucherStatus {
  initial,
  loading,
  success,
  failure,
}

class VoucherState extends Equatable {
  final String? voucherString;
  final String? message;
  final VoucherStatus status;
  final DiscountData discountData;

  const VoucherState({
    this.discountData = DiscountData.empty,
    this.voucherString,
    this.message,
    this.status = VoucherStatus.initial,
  });

  VoucherState copyWith({
    String? voucherString,
    String? message,
    VoucherStatus? status,
    DiscountData? discountData,
  }) {
    return VoucherState(
      voucherString: voucherString ?? this.voucherString,
      message: message ?? this.message,
      status: status ?? this.status,
      discountData: discountData ?? this.discountData,
    );
  }

  @override
  List<Object?> get props => [
        discountData,
        voucherString,
        message,
        status,
      ];
}
