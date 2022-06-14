import 'package:flutter/material.dart';
import 'package:nanoshop/src/domain/entities/post/post.dart';

import '../widgets/post_list_tile.dart';

class ListVerticalPostWidget extends StatelessWidget {
  final List<Post> posts;

  const ListVerticalPostWidget({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ...List.generate(
          posts.length,
          (index) => PostListTile(
            post: posts[index],
          ),
        )
      ],
    );
  }
}
