import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';

class StarWithRateCount extends StatelessWidget {
  final String rateCount;
  const StarWithRateCount({
    Key? key,
    required this.rateCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          color: AppColors.primaryColor,
          size: 10,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          (rateCount).toString() + '/5',
          maxLines: 1,
          textAlign: TextAlign.end,
          style: TextStyleApp.textStyle4.copyWith(
            color: AppColors.dividerColor,
          ),
        ),
      ],
    );
  }
}
