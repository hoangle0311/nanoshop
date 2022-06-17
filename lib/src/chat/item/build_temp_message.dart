import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/Dbkeys.dart';
import '../config/Enum.dart';
import '../provider/Observer.dart';
import '../provider/seen_provider.dart';
import '../utils/color.dart';
import '../utils/save.dart';
import 'bubble.dart';
import 'item_selectablelinkify.dart';

Widget BuildTempMessage(BuildContext context, MessageType type, content,
    timestamp, delivered, tempDoc,currentUserNo,seenState,messages,urlAvatar) {
  final observer = Provider.of<Observer>(context, listen: false);
  final bool isMe = true;
  return SeenProvider(
      timestamp: timestamp.toString(),
      data: seenState,
      child: Bubble(
        is24hrsFormat: observer.is24hrsTimeformat,
        isMssgDeleted: ((tempDoc.containsKey(Dbkeys.hasRecipientDeleted) &&
            tempDoc.containsKey(Dbkeys.hasSenderDeleted)) ==
            true)
            ? (isMe == true
            ? (tempDoc[Dbkeys.from] == currentUserNo
            ? tempDoc[Dbkeys.hasSenderDeleted]
            : false)
            : (tempDoc[Dbkeys.from] != currentUserNo
            ? tempDoc[Dbkeys.hasRecipientDeleted]
            : false))
            : false,
        isBroadcastMssg: false,
        messagetype: type,
        child: type == MessageType.text
            ? getTempTextMessage(content, isMe)
            : getTempImageMessage(url: content),
        isMe: isMe,
        timestamp: timestamp,
        delivered: delivered,
        isContinuing:
        messages.isNotEmpty && messages.last.from == currentUserNo,
          isEnd: messages.isNotEmpty && messages.last.from != currentUserNo,
        urlAvatar: urlAvatar,
        currentUserNo: currentUserNo,
        peerNo: tempDoc[Dbkeys.to],
      ),
  );
}
Widget getTempImageMessage({String? url, imageFile}) {
  return imageFile != null
      ? Container(
    child: Image.file(
      imageFile!,
      // width: url!.contains('giphy') ? 120 : 200.0,
      // height: url.contains('giphy') ? 120 : 200.0,
      //fit: BoxFit.cover,
    ),
  )
      : getImageMessage({Dbkeys.content: url});
}

Widget getImageMessage(Map<String, dynamic> doc, {bool saved = false}) {
  return Container(
    child: saved
        ? Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: Save.getImageFromBase64(doc[Dbkeys.content]).image,
           // fit: BoxFit.cover,
        ),
      ),
      // width: doc[Dbkeys.content].contains('giphy') ? 120 : 200.0,
      // height: doc[Dbkeys.content].contains('giphy') ? 102 : 200.0,
    )
        : CachedNetworkImage(
      placeholder: (context, url) => Container(
        child: CircularProgressIndicator(),
        width: doc[Dbkeys.content].contains('giphy') ? 120 : 200.0,
        height: doc[Dbkeys.content].contains('giphy') ? 120 : 200.0,
        padding: EdgeInsets.all(80.0),
      ),
      errorWidget: (context, str, error) => Material(
        child: Icon(
          Icons.image,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        clipBehavior: Clip.hardEdge,
      ),
      imageUrl: doc[Dbkeys.content],
      //width: doc[Dbkeys.content].contains('giphy') ? 120 : 200.0,
      //height: doc[Dbkeys.content].contains('giphy') ? 120 : 200.0,
      //fit: BoxFit.cover,
    ),
  );
}

Widget getTempTextMessage(String message, bool isMe) {
  return ItemSelectable(
    text: message,
    fontsize: 16,
    isMe: isMe,
  );
}