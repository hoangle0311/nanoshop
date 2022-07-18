import 'package:nanoshop/src/core/params/list_post_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/entities/post/post.dart';

import '../../../core/params/post_param.dart';

abstract class PostRepository {
  Future<DataState<List<Post>>> getListPostRemote(PostParam param);
  Future<DataState<Post>> getDetailPostRemote(DetailPostParam param);
}
