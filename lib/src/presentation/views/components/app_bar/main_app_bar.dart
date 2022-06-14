import 'package:flutter/material.dart';
import 'package:nanoshop/src/core/assets/image_path.dart';

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;

  const PageAppBar({
    Key? key,
    required this.title,
    this.backgroundColor = Colors.cyan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Image.asset(
            ImagePath.backgroundAppBar,
            fit: BoxFit.fill,
          ),
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          title: Text(
            title,
          ),
          centerTitle: true,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
