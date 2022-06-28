import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'flash_sale_with_list_product_state.dart';

class FlashSaleWithListProductCubit extends Cubit<FlashSaleWithListProductState> {
  FlashSaleWithListProductCubit() : super(FlashSaleWithListProductInitial());
}
