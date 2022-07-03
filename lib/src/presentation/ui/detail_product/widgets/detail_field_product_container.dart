import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';
import 'package:nanoshop/src/presentation/views/components/buttons/button_see_more_widget.dart';

import '../../../../config/styles/app_color.dart';
import '../../../../config/styles/app_text_style.dart';

class DetailFieldProductFragment extends StatefulWidget {
  final String title;
  final Product product;

  const DetailFieldProductFragment({
    Key? key,
    required this.title,
    required this.product,
  }) : super(key: key);

  @override
  State<DetailFieldProductFragment> createState() =>
      _DetailFieldProductFragmentState();
}

class _DetailFieldProductFragmentState
    extends State<DetailFieldProductFragment> {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: HexColor("#F2F2F2"),
              ),
              child: Text(
                widget.title.toUpperCase(),
                style: TextStyleApp.textStyle2.copyWith(
                  color: HexColor("#333333"),
                ),
              ),
            ),
          ),
          if (widget.product.productInfo!.dynamicField != null)
            Html(
              data:widget.product.productInfo!.dynamicField,
              style: {
                "#": Style(
                  maxLines: _isActive ? 3 : null,
                ),
              },
            ),
          ButtonSeeMore(
            isActive: _isActive,
            onTap: () {
              _isActive = !_isActive;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}