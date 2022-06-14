import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';

class ButtonLoading extends StatelessWidget {
  final LinearGradient? gradient;

  const ButtonLoading({
    Key? key,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.primaryColor),
        gradient: gradient,
      ),
      child: const Center(
        child: CupertinoActivityIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
