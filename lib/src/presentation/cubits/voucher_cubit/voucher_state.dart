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

  const VoucherState({
    this.voucherString,
    this.message,
    this.status = VoucherStatus.initial,
  });

  VoucherState copyWith({
    String? voucherString,
    String? message,
    VoucherStatus? status,
  }) {
    return VoucherState(
      voucherString: voucherString ?? this.voucherString,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        voucherString,
        message,
        status,
      ];
}
