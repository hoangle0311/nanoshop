import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/environment/app_environment.dart';
import 'package:nanoshop/src/config/routers/app_router/app_router.dart';
import 'package:nanoshop/src/domain/entities/post/post.dart';
import 'package:nanoshop/src/presentation/views/components/image_widget/load_image_form_url_widget.dart';
import 'package:share/share.dart';

import '../../../../config/styles/app_color.dart';
import '../../../../config/styles/app_text_style.dart';
import '../../../../core/assets/image_path.dart';
import '../../../../core/utils/helper/convert_date_from_millisecond.dart';

class PostListTile extends StatelessWidget {
  final Post post;
  final int index;

  const PostListTile({
    Key? key,
    required this.post,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = "http://plpharma.nanoweb.vn/mediacenter/" +
        (post.imagePath ?? '').toString() +
        (post.imageName ?? '').toString();

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRouterEndPoint.DETAILPOST,
          arguments: index,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: LoadImageFromUrlWidget(
              imageUrl: imageUrl,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.newsTitle ?? '',
                  style: TextStyleApp.textStyle3.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  post.newsSortdesc ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleApp.textStyle2.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildToolBar(
                        title: convertDateFromMilliseconds(
                            post.createdTime ?? '0'),
                        iconSource: ImagePath.clockIcon,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // _buildToolBar(
                          //   title: 'Likes',
                          //   iconSource: ImagePath.favouriteIcon,
                          // ),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          // _buildToolBar(
                          //   title: 'Comment',
                          //   iconSource: ImagePath.messageIcon,
                          // ),
                          SizedBox(
                            width: 5,
                          ),
                          _buildToolBar(
                            onTap: () {
                              Share.share(
                                  Environment.domain + (post.link ?? ''));
                            },
                            title: 'Share',
                            iconSource: ImagePath.shareIcon,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolBar({
    required String iconSource,
    required String title,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(iconSource),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: TextStyleApp.textStyle2.copyWith(
              color: AppColors.dividerColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
