//*************   © Copyrighted by Thinkcreative_Technologies. An Exclusive item of Envato market. Make sure you have purchased a Regular License OR Extended license for the Source Code from Envato to use this product. See the License Defination attached with source code. *********************

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../config/Enum.dart';
import '../config/string_path.dart';
import '../provider/seen_provider.dart';
import '../utils/color.dart';
import 'load_image.dart';

class Bubble extends StatelessWidget {
  const Bubble({
    required this.child,
    required this.timestamp,
    required this.delivered,
    required this.isMe,
    required this.isContinuing,
    required this.messagetype,
    this.isBroadcastMssg,
    required this.isMssgDeleted,
    required this.is24hrsFormat,
    this.currentUserNo,
    this.peerNo,
    required this.isEnd,
    this.urlAvatar = "",
  });

  final String? currentUserNo, peerNo;
  final dynamic messagetype;
  final int? timestamp;
  final Widget child;
  final dynamic delivered;
  final bool isMe, isContinuing, isMssgDeleted;
  final bool? isBroadcastMssg;
  final bool is24hrsFormat;
  final bool isEnd;
  final String urlAvatar;

  humanReadableTime() => DateFormat(is24hrsFormat == true ? 'HH:mm' : 'h:mm a')
      .format(DateTime.fromMillisecondsSinceEpoch(timestamp!));

  getSeenStatus(seen) {
    if (seen is bool) return true;
    if (seen is String) return true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final bool seen = getSeenStatus(SeenProvider.of(context).value);
    final bg = isMe ? fiberchatBlue : fiberchatGrey;
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    dynamic icon = delivered is bool && delivered
        ? (seen ? Icons.done_all : Icons.done)
        : Icons.access_time;
    final color = isMe
        ? fiberchatBlack.withOpacity(0.5)
        : fiberchatBlack.withOpacity(0.5);
    icon = Icon(icon, size: 14.0, color: seen ? Colors.lightBlue : color);
    if (delivered is Future) {
      icon = FutureBuilder(
          future: delivered,
          builder: (context, res) {
            switch (res.connectionState) {
              case ConnectionState.done:
                return Icon((seen ? Icons.done_all : Icons.done),
                    size: 13.0, color: seen ? Colors.lightBlue : color);
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
              default:
                return Icon(Icons.access_time,
                    size: 13.0, color: seen ? Colors.lightBlue : color);
            }
          });
    }
    dynamic radius = isMe
        ? BorderRadius.only(
            topLeft: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(5.0),
          )
        : BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(5.0),
          );
    dynamic margin = const EdgeInsets.only(top: 20.0, bottom: 1.5);
    if (isContinuing) {
      radius = isMe
          ? BorderRadius.horizontal(
              left: Radius.circular(20), right: Radius.circular(5))
          : BorderRadius.horizontal(
              right: Radius.circular(20), left: Radius.circular(5));
      margin = const EdgeInsets.all(1.9);
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: align,
        children: <Widget>[
          Container(
            margin: margin,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    !isMe
                        ? Container(
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: LoadImage(
                                url: urlAvatar,
                                height: 35,
                                width: 35,
                              ),
                            ),
                          )
                        : Container(),
                    messagetype == MessageType.text ?  Container(
                      padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal: 12),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.67),
                      decoration: BoxDecoration(
                          color: bg,
                          borderRadius: radius,
                      ),
                      child: isMssgDeleted == true
                          ? deletedMessageWidget(
                          isMe, isBroadcastMssg, context, is24hrsFormat)
                          : child,
                    ) : Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.67),
                      decoration: BoxDecoration(
                          borderRadius: radius,
                      ),
                      child: ClipRRect(
                        borderRadius: radius,
                        child: isMssgDeleted == true
                            ? deletedMessageWidget(
                            isMe, isBroadcastMssg, context, is24hrsFormat)
                            : child,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: isMe ? 0 : 50, top: 5),
                  child: Row(
                      mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: <Widget>[
                        isBroadcastMssg == null || isBroadcastMssg == false
                            ? Container(
                          height: 0,
                          width: 0,
                        )
                            : Padding(
                          padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                          child: Icon(
                            Icons.campaign,
                            size: 14.3,
                            color: color,
                          ),
                        ),
                        Text(
                            humanReadableTime().toString() +
                                (isMe ? ' ' : ''),
                            style: TextStyle(
                              color: color,
                              fontSize: 10.0,
                            )),

                        isMe ? icon : SizedBox()
                        // ignore: unnecessary_null_comparison
                      ].where((o) => o != null).toList()),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget deletedMessageWidget(bool isMe, bool? isBroadcastMssg,
    BuildContext context, bool is24hrsFormat) {
  return Padding(
    padding: EdgeInsets.only(
        right: isMe
            ? isBroadcastMssg == null || isBroadcastMssg == false
                ? is24hrsFormat
                    ? 48
                    : 60
                : is24hrsFormat
                    ? 73
                    : 81
            : isBroadcastMssg == null || isBroadcastMssg == false
                ? is24hrsFormat
                    ? 38
                    : 55
                : is24hrsFormat
                    ? 48
                    : 50),
    child: Text(
      delete_message,
      textAlign: isMe ? TextAlign.right : TextAlign.left,
      style: TextStyle(
          fontSize: 15.0, fontStyle: FontStyle.italic, color: Colors.white),
    ),
  );
}
