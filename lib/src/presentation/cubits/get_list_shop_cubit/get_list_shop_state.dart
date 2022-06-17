part of 'get_list_shop_cubit.dart';

enum GetListShopStatus {
  initial,
  loading,
  failure,
  success,
}

class GetListShopState extends Equatable {
  final GetListShopStatus status;
  final List<Shop> shops;
  final GetListShopParam? param;

  const GetListShopState({
    this.status = GetListShopStatus.initial,
    this.param,
    this.shops = const [],
  });

  GetListShopState copyWith({
    GetListShopStatus? status,
    List<Shop>? shops,
    GetListShopParam? param,
  }) {
    return GetListShopState(
      status: status ?? this.status,
      shops: shops ?? this.shops,
      param: param ?? this.param,
    );
  }

  @override
  List<Object?> get props => [
    status,
    shops,
    param,
  ];
}
