// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final navDataItems = [
  NavData(
    navigatorKey: GlobalKey<NavigatorState>(
      debugLabel: "home",
    ),
    icon: const Icon(Icons.home),
    label: "Trang chủ",
  ),
  NavData(
    navigatorKey: GlobalKey(
      debugLabel: "news",
    ),
    icon: const Icon(Icons.file_copy),
    label: "Tin tức",
  ),
  NavData(
    navigatorKey: GlobalKey(
      debugLabel: "shopping_cart",
    ),
    icon: const Icon(Icons.shopping_cart),
    label: "Giỏ hàng",
  ),
  NavData(
    navigatorKey: GlobalKey(
      debugLabel: "message",
    ),
    icon: const Icon(Icons.message),
    label: "Thông báo",
    needUserAccess: true,
  ),
  NavData(
    navigatorKey: GlobalKey(
      debugLabel: "information",
    ),
    icon: const Icon(Icons.person),
    label: "Tài khoản",
    needUserAccess: true,
  ),
];

class NavData extends Equatable {
  final Icon icon;
  final String label;
  final bool needUserAccess;
  final GlobalKey<NavigatorState> navigatorKey;

  const NavData({
    required this.icon,
    required this.label,
    required this.navigatorKey,
    this.needUserAccess = false,
  });

  @override
  List<Object> get props => [
        icon,
        label,
      ];
}
