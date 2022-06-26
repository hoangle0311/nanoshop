import 'package:nanoshop/src/core/params/list_post_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';

import '../../../core/params/post_param.dart';
import '../../../data/responses/list_post_response_model/list_post_response_model.dart';
import '../../../data/responses/post_response_model/post_response_model.dart';

abstract class PostRepository {
  Future<DataState<PostResponseModel>> getListPostRemote(PostParam param);
  Future<DataState<DetailPostResponseModel>> getDetailPostRemote(DetailPostParam param);
}
