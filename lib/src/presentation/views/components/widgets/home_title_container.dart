import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';

class HomeTitleContainer extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final Color? titleColor;
  final double? titleSize;

  const HomeTitleContainer({
    Key? key,
    required this.title,
    this.onTap,
    this.titleColor,
    this.titleSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyleApp.textStyle5.copyWith(
            color: titleColor ?? AppColors.black,
            fontSize: titleSize ?? 16,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            'Xem tất cả',
            style: TextStyleApp.textStyle1.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
