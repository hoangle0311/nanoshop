import 'package:nanoshop/src/core/assets/image_path.dart';

List dummyBottomNav = const [
  DummyBottomNav(
    name: "Trang chủ",
    url: ImagePath.bottomIconHome,
  ),
  DummyBottomNav(
    name: "Tin tức",
    url: ImagePath.bottomIconNews,
  ),
  DummyBottomNav(
    name: "Thông báo",
    url: ImagePath.appBarIconNotification,
    needUserAccess: true,
  ),
  DummyBottomNav(
    name: "Tài khoản",
    url: ImagePath.bottomIconAccount,
    needUserAccess: true,
  ),
];

class DummyBottomNav {
  final String name;
  final String url;
  final bool needUserAccess;

  const DummyBottomNav({
    required this.name,
    required this.url,
    this.needUserAccess = false,
  });
}
