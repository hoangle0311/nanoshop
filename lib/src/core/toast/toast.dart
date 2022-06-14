import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class Toast {
  static showText(
    String text, {
    IconData iconData = Icons.favorite,
  }) {
    BotToast.showCustomText(
        onlyOne: true,
        toastBuilder: (textCancel) => Align(
              alignment: const Alignment(0, 0.8),
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          iconData,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          textCancel();
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        text,
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
