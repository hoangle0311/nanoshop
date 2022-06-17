import 'package:flutter/material.dart';

import '../../../../config/styles/app_color.dart';
import '../buttons/button_with_center_title.dart';

class BottomNavText extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final bool isShowGradient;

  const BottomNavText({
    Key? key,
    required this.title,
    this.onTap,
    this.isShowGradient = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            HexColor("#030102"),
            HexColor("#3A3A3A"),
          ],
        ),
      ),
      child: ButtonWithCenterTitle(
        title: title,
        onTap: onTap,
        gradient: isShowGradient
            ? LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.accentPrimaryColor,
                ],
              )
            : null,
      ),
    );
  }
}
