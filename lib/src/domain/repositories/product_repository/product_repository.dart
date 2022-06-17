import 'package:nanoshop/src/core/params/add_comment_param.dart';
import 'package:nanoshop/src/core/params/get_list_comment_param.dart';
import 'package:nanoshop/src/core/params/product_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/data/models/comment_response_model/comment_response_model.dart';
import 'package:nanoshop/src/data/models/product_response_model/detail_product_response_model.dart';
import 'package:nanoshop/src/domain/entities/flash_sale/flash_sale.dart';

import '../../../core/params/detail_product_param.dart';
import '../../../core/params/related_product_param.dart';
import '../../../data/models/add_comment_response/add_comment_response_model.dart';
import '../../../data/models/flash_sale_response_model/flash_sale_response_model.dart';
import '../../../data/models/product_response_model/product_response_model.dart';
import '../../../data/models/user/user_login_response_model.dart';
import '../../entities/product/product.dart';

abstract class ProductRepository {
  Future<DataState<ProductResponseModel>> getListProductRemote(
    ProductParam param,
  );

  Future<DataState<ProductResponseModel>> getListRelatedProductRemote(
    RelatedProductParam param,
  );

  Future<DataState<DetailProductResponseModel>> getDetailProductRemote(
    DetailProductParam param,
  );

  Future<DataState<FlashSaleResponseModel>> getListProductFlashSaleRemote(
      String params);

  Future<DataState<AddCommentResponseModel>> addCommentRemote(
    AddCommentParam params,
  );

  Future<DataState<CommentResponseModel>> getListCommentRemote(
    GetListCommentParam params,
  );

  List<Product> getListFavouriteProductLocal();

  Future<void> addFavouriteProductLocal(Product product);

  Future<void> removeFavouriteProductLocal(Product product);
}
