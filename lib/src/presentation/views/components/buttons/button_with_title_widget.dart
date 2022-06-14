import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';

class ButtonWithTitleWidget extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final LinearGradient? gradient;

  const ButtonWithTitleWidget({
    Key? key,
    this.onTap,
    this.gradient,
    this.title = "Xem thêm",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(30),
          gradient: gradient,
        ),
        child: Text(
          title,
          style: TextStyleApp.textStyle1,
        ),
      ),
    );
  }
}
