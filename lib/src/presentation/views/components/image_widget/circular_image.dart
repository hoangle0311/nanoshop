import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/presentation/views/components/image_widget/load_image_form_url_widget.dart';

class CircularImage extends StatelessWidget {
  final double kImageHeight;
  final String imageUrl;

  const CircularImage({
    Key? key,
    this.kImageHeight = 50,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kImageHeight,
      height: kImageHeight,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
            imageUrl,
          ),

        ),
      ),
      child: Center(
        child: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
    );
  }
}
