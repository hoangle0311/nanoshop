import 'package:flutter/material.dart';

import '../../../../config/styles/app_text_style.dart';

class ButtonIconWithTitle extends StatelessWidget {
  final String title;
  final String assetsSource;
  final Color borderColor;
  final Color textColor;
  final Function()? onTap;

  const ButtonIconWithTitle({
    Key? key,
    required this.title,
    required this.assetsSource,
    this.onTap,
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
          border: Border.all(color: borderColor, width: 0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(assetsSource),
            Center(
              child: Text(
                title,
                style: TextStyleApp.textStyle2.copyWith(
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
