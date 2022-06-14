import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/views/components/post_widget/list_vertical_post_widget.dart';

import '../../../core/hooks/use_scroll_controller_for_lazy_loading_post.dart';
import '../../blocs/post_bloc/post_bloc.dart';
import '../../views/components/loading_widget/list_horizontal_category_loading.dart';

class PostPage extends HookWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _mainScrollController = ScrollController();

    useEffect(() {
      _mainScrollController.addListener(
        () => onUseScrollControllerForLazyLoadingPost(
          context,
          _mainScrollController,
        ),
      );
      return null;
    }, [
      _mainScrollController,
    ]);

    return _body(
      mainScrollController: _mainScrollController,
    );
  }

  Widget _body({
    required ScrollController mainScrollController,
  }) {
    return SingleChildScrollView(
      controller: mainScrollController,
      child: Column(
        children: [
          _verticalListPost(),
        ],
      ),
    );
  }

  Widget _verticalListPost() {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostFailed) {
          return Center(
            child: Text(
              state.dioError?.message ?? "Lỗi khi tải dữ liệu",
            ),
          );
        }

        if (state is PostDone) {
          print(state.posts.length);
          return ListVerticalPostWidget(posts: state.posts);
        }

        return const ListHorizontalCategoryLoading();
      },
    );
  }
}
