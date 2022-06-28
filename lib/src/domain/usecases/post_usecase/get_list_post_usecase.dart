import 'package:nanoshop/src/core/params/post_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';

import '../../../data/responses/post_response_model/post_response_model.dart';
import '../../entities/post/post.dart';
import '../../repositories/post_repository/post_repository.dart';

class GetListPostUsecase extends UseCaseWithFuture<DataState<PostResponseModel>, PostParam> {
  final PostRepository _postRepository;

  GetListPostUsecase(
    this._postRepository,
  );

  @override
  Future<DataState<PostResponseModel>> call(PostParam params) {
    return _postRepository.getListPostRemote(params);
  }
}
