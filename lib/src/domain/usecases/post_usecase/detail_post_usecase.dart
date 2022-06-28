import 'package:nanoshop/src/core/params/list_post_param.dart';
import 'package:nanoshop/src/core/params/post_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';

import '../../../data/responses/list_post_response_model/list_post_response_model.dart';
import '../../entities/post/post.dart';
import '../../repositories/post_repository/post_repository.dart';

class DetailPostUsecase extends UseCaseWithFuture<DataState<DetailPostResponseModel>, DetailPostParam> {
  final PostRepository _postRepository;

  DetailPostUsecase(
      this._postRepository,
      );

  @override
  Future<DataState<DetailPostResponseModel>> call(DetailPostParam params) {
    return _postRepository.getDetailPostRemote(params);
  }
}
