import 'package:nanoshop/src/core/params/add_comment_param.dart';
import 'package:nanoshop/src/core/params/get_list_comment_param.dart';
import 'package:nanoshop/src/core/params/product_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';

import '../../../core/params/detail_product_param.dart';
import '../../../core/params/list_flashsale_with_list_product_param.dart';
import '../../../core/params/related_product_param.dart';
import '../../../core/params/search_product_param.dart';
import '../../../data/responses/add_comment_response/add_comment_response_model.dart';
import '../../../data/responses/comment_response_model/comment_response_model.dart';
import '../../../data/responses/flash_sale_response_model/flash_sale_response_model.dart';
import '../../../data/responses/manufacturer_response_model/manufacturer_response_model.dart';
import '../../../data/responses/product_response_model/detail_product_response_model.dart';
import '../../../data/responses/product_response_model/product_response_model.dart';
import '../../entities/flash_sale/flash_sale.dart';
import '../../entities/product/product.dart';

abstract class ProductRepository {
  Future<DataState<List<Product>>> getListProductRemote(
    ProductParam param,
  );

  Future<DataState<List<Product>>> getSearchListProductRemote(
    SearchProductParam param,
  );

  Future<DataState<List<Product>>> getListRelatedProductRemote(
    RelatedProductParam param,
  );

  Future<DataState<DetailProductResponseModel>> getDetailProductRemote(
    DetailProductParam param,
  );

  Future<DataState<List<FlashSale>>> getListFlashSaleRemote(
      String params);

  Future<DataState<List<Product>>> getListFlashSaleWithListProductRemote(
    ListFlashSaleWithListProductParam params,
  );

  Future<DataState<AddCommentResponseModel>> addCommentRemote(
    AddCommentParam params,
  );

  Future<DataState<CommentResponseModel>> getListCommentRemote(
    GetListCommentParam params,
  );

  Future<DataState<ManufacturerResponseModel>> getListManufacturer(
    String token,
  );

  List<Product> getListFavouriteProductLocal();

  Future<void> addFavouriteProductLocal(Product product);

  Future<void> removeFavouriteProductLocal(Product product);
}
