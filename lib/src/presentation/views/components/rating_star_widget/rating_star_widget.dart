import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';

class RatingStarWidget extends StatelessWidget {
  final double rating;
  final double kSizeStar;

  final total = 5;

  const RatingStarWidget({
    Key? key,
    this.kSizeStar = 18,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        total,
        (index) {
          return rating >= double.parse((index + 1).toString())
              ? Icon(
                  Icons.star,
                  size: kSizeStar,
                  color: AppColors.yellow,
                )
              : rating > double.parse((index + 0.5).toString())
                  ? Icon(
                      Icons.star_half,
                      size: kSizeStar,
                      color: AppColors.yellow,
                    )
                  : Icon(
                      Icons.star_border,
                      size: kSizeStar,
                      color: AppColors.grey,
                    );
        },
      ),
    );
  }
}
