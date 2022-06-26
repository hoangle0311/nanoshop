import 'package:nanoshop/src/core/params/add_comment_param.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';

import '../../../core/resource/data_state.dart';
import '../../../data/responses/add_comment_response/add_comment_response_model.dart';
import '../../repositories/product_repository/product_repository.dart';

class AddCommentUsecase extends UseCaseWithFuture<
    DataState<AddCommentResponseModel>, AddCommentParam> {
  final ProductRepository _productRepository;

  AddCommentUsecase(
    this._productRepository,
  );

  @override
  Future<DataState<AddCommentResponseModel>> call(AddCommentParam params) {
    return _productRepository.addCommentRemote(params);
  }
}
