import 'package:nanoshop/src/core/assets/image_path.dart';

var dummyMenu = [
  DummyMenu(
    name: "Thông báo",
    url: ImagePath.notificationMenuIcon,
  ),
  DummyMenu(
    name: "Đơn hàng",
    url: ImagePath.fileMenuIcon,
  ),
  // DummyMenu(
  //   name: "Hệ thống cửa hàng",
  //   url: ImagePath.groupShopIcon,
  //   onTap: () {
  //     Get.toNamed(RouterApp.chooseShopScreen);
  //   },
  // ),
  DummyMenu(
    name: "Lịch sử thanh toán",
    url: ImagePath.walletMenuIcon,
  ),
  DummyMenu(
    name: "Liên hệ",
    url: ImagePath.phoneMenuIcon,
  ),
  DummyMenu(
    name: "Hỏi & đáp",
    url: ImagePath.attentionMenuIcon,
  ),
];

class DummyMenu {
  final String name;
  final String url;

  DummyMenu({
    required this.name,
    required this.url,
  });
}
