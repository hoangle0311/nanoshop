import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';

import '../../../../config/styles/app_text_style.dart';

class ButtonWithCenterTitle extends StatelessWidget {
  final String title;
  final Color borderColor;
  final Color textColor;
  final Function()? onTap;
  final LinearGradient? gradient;

  const ButtonWithCenterTitle({
    Key? key,
    required this.title,
    this.onTap,
    this.gradient,
    this.borderColor = Colors.white,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.primaryColor),
          gradient: gradient,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyleApp.textStyle1.copyWith(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
