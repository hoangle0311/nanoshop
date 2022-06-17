import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/color.dart';

Widget BuildInputChat({
  required BuildContext context,
  required bool isemojiShowing,
  required Function refreshThisInput,
  required bool keyboardVisible,
  required TextEditingController textSend,
  required chatStatus,
  required keyboardFocusNode,
  Function()? onSendText,
  Function()? onSendImageCamera,
  Function()? onSendFile,
}) {
  return Container(
    padding: EdgeInsets.only(top: 5, bottom: 20, right: 10, left: 10),
    height: 70,
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        textSend.text.isNotEmpty
            ? SizedBox()
            : Row(
                children: [
                  IconButton(
                    onPressed: onSendImageCamera,
                    icon: Icon(
                      CupertinoIcons.camera_on_rectangle,
                      size: 30,
                    ),
                  ),
                  // IconButton(
                  //   onPressed: onSendFile,
                  //   icon: Icon(
                  //     Icons.link,
                  //     size: 30,
                  //   ),
                  // ),
                ],
              ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: TextField(
              onTap: () {
                if (isemojiShowing == true) {
                } else {
                  keyboardFocusNode.requestFocus();
                }
              },
              showCursor: true,
              focusNode: keyboardFocusNode,
              maxLines: null,
              style: TextStyle(fontSize: 16.0, color: fiberchatBlack),
              controller: textSend,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: onSendText,
                  child: Icon(Icons.send_outlined),
                ),
                enabledBorder: OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderRadius: BorderRadius.circular(1),
                  borderSide: BorderSide(color: Colors.transparent, width: 1.5),
                ),
                hoverColor: Colors.transparent,
                focusedBorder: OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderRadius: BorderRadius.circular(1),
                  borderSide: BorderSide(color: Colors.transparent, width: 1.5),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(1),
                    borderSide: BorderSide(color: Colors.transparent)),
                contentPadding: EdgeInsets.fromLTRB(10, 4, 7, 4),
                hintText: 'Nhập tin nhắn',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
