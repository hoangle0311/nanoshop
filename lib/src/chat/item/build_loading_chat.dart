import 'package:flutter/material.dart';

Widget BuildLoadingChat(bool isLoading) {
  return Positioned(
    child: isLoading
        ? Center(
          child: CircularProgressIndicator(),
        )
        : Container(
      width: 0,
      height: 0,
    ),
  );
}