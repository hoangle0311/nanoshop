import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';

class CustomDialogWithIcon extends StatelessWidget {
  final String assetsSource;
  final String title;

  const CustomDialogWithIcon({
    Key? key,
    required this.assetsSource,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout,
                size: 42,
                color: AppColors.primaryColor,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: TextStyleApp.textStyle3.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      "Đồng ý",
                      style: TextStyleApp.textStyle1.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      'Hủy bỏ',
                      style: TextStyleApp.textStyle1.copyWith(
                        color: AppColors.dividerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
