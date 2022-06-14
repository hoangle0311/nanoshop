import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/data/models/post_response_model/post_response_model.dart';

import '../../../core/params/post_param.dart';
import '../../entities/post/post.dart';

abstract class PostRepository {
  Future<DataState<PostResponseModel>> getListPostRemote(PostParam param);
}
