import 'package:flutter/material.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';
import 'package:permission_handler/permission_handler.dart';

import '../color_app.dart';
import '../item/button1.dart';


class OpenSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(title: "Cấp quyền ứng dụng"),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(30),
            child: Text(
              '1. Mở Cài đặt ứng dụng. \n \n2. Đi tới Quyền. \n \n3. Cho phép quyền đối với dịch vụ được yêu cầu. \n \n4. Quay lại ứng dụng và tải lại trang.',
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorApp.colorMain),
            ),
          ),
          Button1(
            title: "Mở cài đặt",
            onTap: () {
              openAppSettings();
            },
            width: 150,
            height: 45,
            textColor: Colors.white,
          ),
        ],
      )),
    );
  }
}
