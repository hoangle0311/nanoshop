import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color_app.dart';

class LoadImage extends StatefulWidget {
  String url;
  double width;
  double height;
  BoxFit fit;
  bool hasBorder;

  LoadImage({
    required this.url,
    this.height = double.infinity,
    this.width = double.infinity,
    this.fit = BoxFit.contain,
    this.hasBorder = false,
  });

  @override
  _LoadImageState createState() => _LoadImageState();
}

class _LoadImageState extends State<LoadImage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.hasBorder ? 15 : 0),
      child: Image.network(
        widget.url,
        fit: widget.fit,
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Container(
            width: widget.width,
            height: widget.height,
            child: Center(
              child: Platform.isAndroid
                  ? const CircularProgressIndicator(
                color: ColorApp.colorMain,
                strokeWidth: 2,
              )
                  : CupertinoActivityIndicator(),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: widget.width,
            height: widget.height,
            color: ColorApp.colorMain.withOpacity(.1),
            child: Center(
              child: Icon(
                Icons.image,
              ),
            ),
          );
        },
      ),
    );
  }
}
