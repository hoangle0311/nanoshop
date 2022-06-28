import 'package:nanoshop/src/core/params/get_list_comment_param.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';

import '../../../core/resource/data_state.dart';
import '../../../data/responses/comment_response_model/comment_response_model.dart';
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
