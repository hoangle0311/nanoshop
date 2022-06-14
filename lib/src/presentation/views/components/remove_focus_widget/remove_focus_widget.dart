import 'package:flutter/material.dart';

class RemoveFocusWidget extends StatelessWidget {
  final Widget child;

  const RemoveFocusWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: child,
    );
  }
}
