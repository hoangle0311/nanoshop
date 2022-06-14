import 'package:flutter/material.dart';

class ButtonSeeMore extends StatelessWidget {
  final bool isActive;

  final Function()? onTap;

  const ButtonSeeMore({
    Key? key,
    this.onTap,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                isActive ? "Rút gọn" : 'Xem thêm',
              ),
            ),
            Icon(
              Icons.arrow_forward_outlined,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
