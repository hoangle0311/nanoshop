import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/entities/flash_sale/flash_sale.dart';
import 'package:nanoshop/src/domain/usecases/product_usecase/get_flash_sale_product_usecase.dart';

part 'flash_sale_event.dart';
part 'flash_sale_state.dart';

class FlashSaleBloc extends Bloc<FlashSaleEvent, FlashSaleState> {
  final GetListFlashSaleProductRemoteUsecase
      _getListFlashSaleProductRemoteUsecase;

  FlashSaleBloc(
    this._getListFlashSaleProductRemoteUsecase,
  ) : super(
          const FlashSaleState(),
        ) {
    on<GetFlashSale>(
      _onGetFlashSale,
    );
  }

  _onGetFlashSale(
    GetFlashSale event,
    emit,
  ) async {
    DataState dataState =
        await _getListFlashSaleProductRemoteUsecase.call(null);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(
          flashSale: dataState.data,
          status: FlashSaleStatus.running,
        ),
      );
    }

    if (dataState is DataFailed) {
      emit(
        state.copyWith(
          status: FlashSaleStatus.complete,
        ),
      );
    }
  }
}
