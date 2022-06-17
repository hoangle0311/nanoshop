import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/Dbkeys.dart';
import '../config/Enum.dart';
import '../models/data_model.dart';
import '../provider/Observer.dart';
import '../provider/seen_provider.dart';
import 'bubble.dart';
import 'build_temp_message.dart';

Widget BuildMessage(BuildContext context, Map<String, dynamic> doc,
    {required List messages,
    required currentUserNo,
    required peerNo,
    required seenState,
    required DataModel cachedModel,
      urlAvatar,
    }) {
  final observer = Provider.of<Observer>(context, listen: false);
  final bool isMe = doc[Dbkeys.from] == currentUserNo;
  bool isContinuing =
      messages.isNotEmpty ? messages.last.from == doc[Dbkeys.from] : false;
  bool isEnd =
      messages.isNotEmpty ? messages.last.from != doc[Dbkeys.from] : false;

  return SeenProvider(
    timestamp: doc[Dbkeys.timestamp].toString(),
    data: seenState,
    child: Bubble(
      currentUserNo: currentUserNo ?? "",
      peerNo: peerNo ?? "",
      is24hrsFormat: observer.is24hrsTimeformat,
      isMssgDeleted: (doc.containsKey(Dbkeys.hasRecipientDeleted) &&
              doc.containsKey(Dbkeys.hasSenderDeleted))
          ? isMe
              ? (doc[Dbkeys.from] == currentUserNo
                  ? doc[Dbkeys.hasSenderDeleted]
                  : false)
              : (doc[Dbkeys.from] != currentUserNo
                  ? doc[Dbkeys.hasRecipientDeleted]
                  : false)
          : false,
      isBroadcastMssg: doc.containsKey(Dbkeys.isbroadcast) == true
          ? doc[Dbkeys.isbroadcast]
          : false,
      messagetype: doc[Dbkeys.messageType] == MessageType.text.index
          ? MessageType.text
          : doc[Dbkeys.messageType] == MessageType.contact.index
              ? MessageType.contact
              : doc[Dbkeys.messageType] == MessageType.location.index
                  ? MessageType.location
                  : doc[Dbkeys.messageType] == MessageType.image.index
                      ? MessageType.image
                      : doc[Dbkeys.messageType] == MessageType.video.index
                          ? MessageType.video
                          : doc[Dbkeys.messageType] == MessageType.doc.index
                              ? MessageType.doc
                              : doc[Dbkeys.messageType] ==
                                      MessageType.audio.index
                                  ? MessageType.audio
                                  : doc[Dbkeys.messageType] ==
                                          MessageType.text.index
                                      ? MessageType.text
                                      : MessageType.title,
      child: doc[Dbkeys.messageType] == MessageType.text.index
          ? getTempTextMessage(doc[Dbkeys.content], isMe)
          : getImageMessage(
              doc,
              saved: false,
            ),
      isMe: isMe,
      timestamp: doc[Dbkeys.timestamp],
      delivered: cachedModel.getMessageStatus(peerNo, doc[Dbkeys.timestamp]),
      isContinuing: isContinuing,
      isEnd: isEnd,
      urlAvatar: urlAvatar,
    ),
  );
}
