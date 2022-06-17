part of 'flash_sale_bloc.dart';

abstract class FlashSaleEvent extends Equatable {
  const FlashSaleEvent();

  @override
  List<Object> get props => [];
}

class GetFlashSale extends FlashSaleEvent {
  final TokenParam tokenParam;

  const GetFlashSale({
    required this.tokenParam,
  });
}
