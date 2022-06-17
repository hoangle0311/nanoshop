import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';

class TitleForm extends StatelessWidget {
  final String title;
  const TitleForm({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyleApp.textStyle2.copyWith(
        color: AppColors.accentPrimaryColor,
        fontSize: 21,
      ),
    );
  }
}
