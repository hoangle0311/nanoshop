import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Banner;

import '../../../../domain/entities/banner/banner.dart';

class LoadImageFromUrlWidget extends StatelessWidget {
  final String imageUrl;
  final double? height;

  const LoadImageFromUrlWidget({
    Key? key,
    this.height,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      color: Colors.white,
      child: Image.network(
        imageUrl,
        fit: BoxFit.fill,
        errorBuilder: ((context, error, stackTrace) => Container(
              child: const Center(
                child: Icon(
                  Icons.image,
                  size: 32,
                ),
              ),
            )),
      ),
    );
  }
}
