import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/domain/entities/filter_model/filter_model.dart';

import '../../../../config/styles/app_text_style.dart';

class DropDownField extends StatelessWidget {
  final List listItem;
  final String hint;
  final FilterModel? value;
  final ValueChanged onChanged;

  const DropDownField({
    Key? key,
    required this.listItem,
    required this.hint,
    this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: <Color>[
            AppColors.primaryColor,
            AppColors.yellow,
          ],
        ).createShader(bounds);
      },
      child: DropdownButtonFormField(
        value: value,
        onChanged: onChanged,
        isExpanded: true,
        hint: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            hint,
            style: TextStyleApp.textStyle2.copyWith(
              color: AppColors.dividerColor,
            ),
          ),
        ),
        style: TextStyleApp.textStyle2,
        decoration: InputDecoration(
          // hintText: widget.hint,
          hintStyle: TextStyleApp.textStyle2.copyWith(
            color: AppColors.black.withOpacity(0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.8), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        ),
        items: List.generate(
          listItem.length,
          (index) => DropdownMenuItem(
            child: Text(
              listItem[index].name.toString(),
              style: TextStyleApp.textStyle1.copyWith(
                color: AppColors.primaryColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            value: listItem[index],
          ),
        ),
      ),
    );
  }
}
