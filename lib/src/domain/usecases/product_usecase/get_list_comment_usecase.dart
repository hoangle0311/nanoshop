import 'package:nanoshop/src/core/params/add_comment_param.dart';
import 'package:nanoshop/src/core/params/get_list_comment_param.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/data/models/add_comment_response/add_comment_response_model.dart';
import 'package:nanoshop/src/data/models/comment_response_model/comment_response_model.dart';

import '../../../core/resource/data_state.dart';
import '../../entities/product/product.dart';
import '../../repositories/product_repository/product_repository.dart';

class GetListCommentUsecase extends UseCaseWithFuture<
    DataState<CommentResponseModel>, GetListCommentParam> {
  final ProductRepository _productRepository;

  GetListCommentUsecase(
      this._productRepository,
      );

  @override
  Future<DataState<CommentResponseModel>> call(GetListCommentParam params) {
    return _productRepository.getListCommentRemote(params);
  }
}
