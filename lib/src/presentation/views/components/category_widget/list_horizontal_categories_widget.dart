import 'package:flutter/material.dart';
import 'package:nanoshop/src/presentation/views/components/image_widget/load_image_form_url_widget.dart';

import '../../../../config/styles/app_color.dart';
import '../../../../config/styles/app_text_style.dart';
import '../../../../domain/entities/category/category.dart';

class ListHorizontalCategoriesWidget extends StatelessWidget {
  final List<Category> categories;

  Widget _itemCategory(dynamic model) {
    var imageUrl = "http://plpharma.nanoweb.vn/mediacenter" +
        (model.imagePath + model.imageName);

    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        // decoration: BoxDecoration(
        //   border: Border(
        //     top: BorderSide(width: 0.48, color: AppColor.color8.withOpacity(0.3)),
        //     bottom:
        //         BorderSide(width: 0.48, color: AppColor.color8.withOpacity(0.3)),
        //     left:
        //         BorderSide(width: 0.48, color: AppColor.color8.withOpacity(0.3)),
        //   ),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    width: 57,
                    height: 57,
                  ),
                ),
                Center(
                  child: Container(
                    width: 57,
                    height: 57,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    child: Container(
                      width: 44,
                      height: 38,
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LoadImageFromUrlWidget(
                          imageUrl: imageUrl,
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 57,
              child: Center(
                child: Text(
                  model.catName,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyleApp.textStyle4.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _itemCategory(Category category) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
  //     decoration: BoxDecoration(
  //       border: Border(
  //         top: BorderSide(
  //             width: 0.48, color: AppColors.primaryColor.withOpacity(0.3)),
  //         bottom: BorderSide(
  //             width: 0.48, color: AppColors.primaryColor.withOpacity(0.3)),
  //         left: BorderSide(
  //             width: 0.48, color: AppColors.primaryColor.withOpacity(0.3)),
  //       ),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Stack(
  //           children: [
  //             Center(
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   color: AppColors.primaryColor.withOpacity(0.15),
  //                   shape: BoxShape.circle,
  //                 ),
  //                 width: 57,
  //                 height: 57,
  //               ),
  //             ),
  //             Center(
  //               child: Container(
  //                 width: 57,
  //                 height: 57,
  //                 child: Container(
  //                   width: 44,
  //                   height: 38,
  //                   alignment: Alignment.bottomCenter,
  //                   child: LoadImageFromUrlWidget(
  //                     imageUrl: (category.imageName ?? "") +
  //                         (category.imagePath ?? ""),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         Container(
  //           child: Center(
  //             child: Text(
  //               category.catName ?? "",
  //               textAlign: TextAlign.center,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  const ListHorizontalCategoriesWidget({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          IntrinsicHeight(
            child: Row(
              children: categories
                  .map(
                    (e) => _itemCategory(e),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
