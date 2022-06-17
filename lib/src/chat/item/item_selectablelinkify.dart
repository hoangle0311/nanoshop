import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:nanoshop/src/chat/text_style_chat.dart';
import 'package:url_launcher/url_launcher.dart';

import '../color_app.dart';
class ItemSelectable extends StatelessWidget {
  String? text; double fontsize;
  bool isMe;
  ItemSelectable({this.text, this.fontsize = 14,required this.isMe});
  @override
  Widget build(BuildContext context) {
    return SelectableLinkify(
      style: TextStyleApp.textStyle400(fontSize: fontsize, color: isMe ? Colors.white : ColorApp.colorBlack),
      text: text ?? "",
      onOpen: (link) async {
        if (await canLaunch(link.url)) {
          await launch(link.url);
        } else {
          throw 'Could not launch $link';
        }
      },
    );
  }
}
