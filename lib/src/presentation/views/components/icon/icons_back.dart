import 'dart:io';

import 'package:flutter/material.dart';

class IconsBack extends StatelessWidget {
  final Function()? onTap;
  const IconsBack({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        Platform.isAndroid ? Icons.arrow_back : Icons.chevron_left,
        color: Colors.white,
      ),
    );
  }
}
