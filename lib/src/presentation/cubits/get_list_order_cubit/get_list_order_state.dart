part of 'get_list_order_cubit.dart';

enum GetListOrderStatus {
  initial,
  loading,
  success,
  failure,
}

class GetListOrderState extends Equatable {
  final GetListOrderStatus status;
  final List<Order> orders;
  final bool hasMore;
  final int page;
  final GetListOrderParam? param;

  const GetListOrderState({
    this.status = GetListOrderStatus.initial,
    this.orders = const [],
    this.hasMore = true,
    this.param,
    this.page = 0,
  });

  GetListOrderState copyWith({
    GetListOrderStatus? status,
    List<Order>? orders,
    bool? hasMore,
    int? page,
    GetListOrderParam? param,
  }) {
    return GetListOrderState(
      param: param ?? this.param,
      status: status ?? this.status,
      orders: orders ?? this.orders,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [
        status,
        orders,
        hasMore,
        page,
        param,
      ];
}
