import 'package:flutter/material.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';

class ScListShop extends StatelessWidget {
  const ScListShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: 'Hệ thống cơ sở',
      ),

    );
  }
}
