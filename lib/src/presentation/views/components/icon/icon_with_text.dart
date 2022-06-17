import 'package:flutter/material.dart';

import '../../../../config/styles/app_color.dart';
import '../../../../config/styles/app_text_style.dart';

class IconWithText extends StatelessWidget {
  final IconData iconData;
  final String title;

  const IconWithText({
    Key? key,
    required this.iconData,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: AppColors.white,
          size: 14,
        ),
        SizedBox(
          width: 7,
        ),
        Text(
          title,
          style: TextStyleApp.textStyle1.copyWith(
            color: AppColors.white,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
