import 'package:flutter/material.dart';
import 'package:nanoshop/src/core/assets/image_path.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';

import '../../../config/styles/app_color.dart';
import '../../../config/styles/app_text_style.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PageAppBar(
            title: 'Thông báo',
          ),
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
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String sub;
  final String url;
  final int count;
  final GestureTapCallback? onTap;

  NotificationItem({
    required this.title,
    required this.url,
    required this.sub,
    this.onTap,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.grey, width: 1),
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                height: 55,
                width: 55,
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(55),
                  border: Border.all(color: AppColors.grey, width: 1),
                ),
                child: Image.asset(
                  url,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleApp.textStyle1.copyWith(
                        color: AppColors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      sub,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleApp.textStyle2.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
              count != null && count > 0
                  ? SizedBox(
                      width: 10,
                    )
                  : Container(),
              count != null && count > 0
                  ? Container(
                      height: 21,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Text(
                            count > 99 ? "99" : "$count",
                            textAlign: TextAlign.center,
                            style: TextStyleApp.textStyle1,
                          ),
                          count != null && count > 99
                              ? Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 12,
                                )
                              : Container()
                        ],
                      ))
                  : Container(),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.navigate_next,
                color: AppColors.dividerColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
