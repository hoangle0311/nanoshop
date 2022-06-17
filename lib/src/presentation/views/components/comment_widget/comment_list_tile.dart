import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/environment/app_environment.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';

import '../../../../config/styles/app_text_style.dart';
import '../../../../domain/entities/comment/comment.dart';
import '../image_widget/circular_image.dart';
import '../rating_star_widget/rating_star_widget.dart';

class CommentListTile extends StatelessWidget {
  final Comment comment;

  const CommentListTile({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageUrl = Environment.domain + '/mediacenter/';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColors.grey,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.grey,
              radius: 26,
              child: Icon(
                Icons.person,
                color: AppColors.white,
              ),
              foregroundImage: NetworkImage(imageUrl),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment.name ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyleApp.textStyle5.copyWith(
                                  fontSize: 14,
                                  color: AppColors.black,
                                ),
                              ),
                              // Text(
                              //   "Đã tham gia 2 tháng",
                              //   maxLines: 1,
                              //   overflow: TextOverflow.ellipsis,
                              //   style: TextStyleApp.textStyle2.copyWith(
                              //     fontSize: 12,
                              //     color: AppColors.primaryColor,
                              //   ),
                              // ),
                              RatingStarWidget(
                                rating: double.parse(comment.rating ?? '0'),
                                kSizeStar: 12,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Đã mua hàng',
                                style: TextStyleApp.textStyle2.copyWith(
                                  fontSize: 12,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    comment.comment ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  // CommentToolbar(
                  //   like: int.parse(model.liked),
                  // ),
                  // if (model.listComment != null)
                  //   Column(
                  //     children: List.generate(
                  //       model.listComment.take(4).length,
                  //       (index) => CommentChildItem(
                  //         model: model.listComment[index],
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
