import 'package:flutter/material.dart';
import 'package:nanoshop/src/domain/entities/post/post.dart';
import 'package:nanoshop/src/presentation/views/components/image_widget/load_image_form_url_widget.dart';

class PostListTile extends StatelessWidget {
  final Post post;

  final Function()? onTap;

  const PostListTile({
    Key? key,
    required this.post,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: LoadImageFromUrlWidget(
            imageUrl: (post.imagePath ?? '').toString() +
                (post.imageName ?? '').toString(),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onTap,
              child: Text(
                post.newsTitle ?? "",
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Text(
                post.newsSortdesc ?? "",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _buildToolBar(
                    title: '22/11/2021',
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildToolBar(
                        title: 'Likes',
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      _buildToolBar(
                        title: 'Comment',
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      _buildToolBar(
                        title: 'Share',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToolBar({
    required String title,
    Function()? onTap,
  }) {
    return Row(
      children: [
        Icon(Icons.lock_clock),
        SizedBox(
          width: 5,
        ),
        Text(
          title,
        ),
      ],
    );
  }
}
