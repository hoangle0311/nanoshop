part of 'get_list_coupon_cubit.dart';

enum GetListCouponStatus {
  initial,
  loading,
  success,
  failure,
}

class GetListCouponState extends Equatable {
  final GetListCouponStatus status;
  final List<DiscountData> listVoucher;

  const GetListCouponState({
    this.status = GetListCouponStatus.initial,
    this.listVoucher = const [],
  });

  GetListCouponState copyWith({
    GetListCouponStatus? status,
    List<DiscountData>? listVoucher,
}){
    return GetListCouponState(
      status: status ?? this.status,
      listVoucher: listVoucher ?? this.listVoucher,
    );
  }

  @override
  List<Object?> get props => [
        status,
        listVoucher,
      ];
}
