import 'package:flutter/material.dart';
import 'package:nanoshop/src/chat/text_style_chat.dart';

import '../color_app.dart';

class Button1 extends StatelessWidget {
  String title;
  Color color;
  Color borderColor;
  Color textColor;
  double height;
  double width;
  bool hasBorder;
  double radius;
  Function()? onTap;

  Button1({
    required this.title,
    this.color = ColorApp.colorMain,
    this.height = 50,
    this.width = double.infinity,
    this.hasBorder = false,
    this.radius = 10,
    this.borderColor = Colors.white,
    this.textColor = Colors.white,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius),
            border: hasBorder ? Border.all(color: borderColor, width: 1) : null),
        child: Text(
          title,
          style: TextStyleApp.textStyle400(color: textColor),
        ),
      ),
    );
  }
}
