import 'package:flutter/material.dart';

import '../../../../config/styles/app_color.dart';
import '../../../../config/styles/app_text_style.dart';

class TextFieldWithIcon extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String value)? onChanged;
  final String? errorText;
  final IconData? iconData;
  final Color color;
  final Color backgroundColor;
  final bool obscureText;
  final int maxLine;
  final bool showIcon;
  final String labelText;
  final double radiusBorder;

  const TextFieldWithIcon({
    Key? key,
    this.iconData,
    this.hint,
    this.errorText,
    required this.labelText,
    this.radiusBorder = 30,
    this.showIcon = true,
    this.backgroundColor = Colors.transparent,
    this.maxLine = 1,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.color = Colors.white,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusBorder),
      ),
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: <Color>[
              AppColors.primaryColor,
              AppColors.accentPrimaryColor,
            ],
          ).createShader(bounds);
        },
        child: TextField(
          maxLines: maxLine,
          // onTap: onTap,
          // readOnly: readOnly,
          onChanged: onChanged,
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
          // onChanged: onChanged,
          // style: StyleTextApp.textStyle400(color: Colors.black),
          cursorColor: Colors.white,
          style: TextStyleApp.textStyle1,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyleApp.textStyle1.copyWith(
              color: AppColors.primaryColor,
            ),
            errorText: errorText,
            errorStyle: TextStyleApp.textStyle1.copyWith(
              color: Colors.red,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radiusBorder),
              borderSide: BorderSide(
                color: color.withOpacity(0.5),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radiusBorder),
              borderSide: BorderSide(color: Colors.white, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(radiusBorder),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(radiusBorder),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            // errorStyle: StyleTextApp.textStyle400(color: Colors.red),
            errorMaxLines: 1,
            hintText: hint,
            hintStyle: TextStyleApp.textStyle2.copyWith(
              color: color.withOpacity(0.5),
            ),
            prefixIcon: showIcon
                ? Icon(
                    iconData,
                    color: color.withOpacity(0.5),
                    size: 18,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
