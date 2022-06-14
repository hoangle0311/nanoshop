import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListHorizontalCategoryLoading extends StatelessWidget {
  const ListHorizontalCategoryLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.3),
      highlightColor: Colors.grey.withOpacity(0.1),
      child: Container(
        color: Colors.red,
        width: size.width,
        height: size.width / 2,
      ),
    );
  }
}
