import 'package:flutter/material.dart';

import '../../../core/assets/image_path.dart';
import '../../pages/notification_page/notification_page.dart';
import '../../views/components/app_bar/main_app_bar.dart';

class ScNotification extends StatelessWidget {
  const ScNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: 'Thông báo',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NotificationItem(
              url: ImagePath.hotSaleIconNotificationScreen,
              sub: "Khuyến mãi",
              title: "Khuyến mãi",
              count: 50,
            ),
            NotificationItem(
              url: ImagePath.updateIconNotificationScreen,
              sub: "Cập nhật TATRA Pharmacy",
              title: "Cập nhật",
              count: 50,
            ),
            NotificationItem(
              url: ImagePath.voucherIconNotificationScreen,
              sub: "Voucher",
              title: "Voucher",
              count: 50,
            ),
          ],
        ),
      ),
    );
  }
}
