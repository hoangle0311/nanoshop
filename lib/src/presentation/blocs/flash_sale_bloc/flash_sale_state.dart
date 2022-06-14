part of 'flash_sale_bloc.dart';

enum FlashSaleStatus {
  initial,
  running,
  complete,
}

class FlashSaleState extends Equatable {
  final FlashSale? flashSale;
  final FlashSaleStatus status;

  const FlashSaleState({
    this.flashSale,
    this.status = FlashSaleStatus.initial,
  });

  FlashSaleState copyWith({
    FlashSale? flashSale,
    FlashSaleStatus? status,
  }) {
    return FlashSaleState(
      flashSale: flashSale ?? this.flashSale,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        flashSale,
        status,
      ];
}
