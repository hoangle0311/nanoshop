import 'package:nanoshop/src/core/params/product_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/entities/flash_sale/flash_sale.dart';

import '../../../data/models/product_response_model/product_response_model.dart';
import '../../../data/models/user/user_login_response_model.dart';
import '../../entities/product/product.dart';

abstract class ProductRepository {
  Future<DataState<ProductResponseModel>> getListProductRemote(
    ProductParam param,
  );

  Future<DataState<FlashSale>> getListProductFlashSaleRemote();

  List<Product> getListFavouriteProductLocal();
  Future<void> addFavouriteProductLocal(Product product);
  Future<void> removeFavouriteProductLocal(Product product);
}
