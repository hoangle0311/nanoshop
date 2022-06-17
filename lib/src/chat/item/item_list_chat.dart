import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nanoshop/src/chat/screen_chat.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../color_app.dart';
import '../config/Dbkeys.dart';
import '../config/Dbpaths.dart';
import '../config/Enum.dart';
import '../config/const_chat.dart';
import '../firebase/firebase_account.dart';
import '../models/data_model.dart';
import '../text_style_chat.dart';
import '../utils/messagedata.dart';
import '../utils/utils.dart';
import 'load_image.dart';

class ItemListChat extends StatefulWidget {
  Map user;
  DataModel model;
  String id;

  ItemListChat({required this.user, required this.model, required this.id});

  @override
  State<ItemListChat> createState() => _ItemListChatState();
}

class _ItemListChatState extends State<ItemListChat> {
  List<StreamSubscription> unreadSubscriptions =
      List.from(<StreamSubscription>[]);

  List<StreamController> controllers = new List.from(<StreamController>[]);
  String url = "";

  getAvatar() async {
    url = await FireBaseAccount.getAvataUser(widget.user[Dbkeys.id]);
    print(url);
  }

  Stream<MessageData> getUnread() {
    String chatId = Fiberchat.getChatId(widget.id, widget.user[Dbkeys.id]);
    var controller = StreamController<MessageData>.broadcast();
    unreadSubscriptions.add(FirebaseFirestore.instance
        .collection(DbPaths.collectionmessages)
        .doc(chatId)
        .snapshots()
        .listen((doc) async {
      if (doc.data()?[widget.id] != null && doc.data()?[widget.id] is int) {
        var res = await FireBaseAccount.getData(widget.user[Dbkeys.id]);
        unreadSubscriptions.add(FirebaseFirestore.instance
            .collection(DbPaths.collectionmessages)
            .doc(chatId)
            .collection(chatId)
            .snapshots()
            .listen((snapshot) {
          controller.add(MessageData(
              snapshot: snapshot,
              lastSeen: doc.data()![widget.id],
              lastMessage: doc.data()![Dbkeys.lastMessage],
              type: doc.data()![Dbkeys.groupTYPE],
              checkStatus: res.data()[Dbkeys.statusChat]));
        }));
      } else {
        await FirebaseFirestore.instance
            .collection(DbPaths.collectionmessages)
            .doc(chatId)
            .set({'${widget.id}': 0}, SetOptions(merge: true));
      }
    }));
    controllers.add(controller);
    return controller.stream;
  }

  getCount(MessageData messageData) {
    int count = messageData.snapshot.docs.isNotEmpty
        ? messageData.snapshot.docs
            .where((t) =>
                t[Dbkeys.timestamp] > messageData.lastSeen &&
                t[Dbkeys.from] != widget.id)
            .length
        : 0;
    return count;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAvatar();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: getUnread().asBroadcastStream(),
        builder: (context, AsyncSnapshot snapshot) {
          if (widget.user[Dbkeys.id] != widget.id && snapshot.hasData) {
            return InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return ScreenChat(
                        arguments: ModelChatScreen(
                      name: widget.user[Dbkeys.nickname],
                      currentUserNo: widget.id,
                      peerNo: widget.user[Dbkeys.id],
                      prefs: prefs,
                      model: widget.model,
                      count: getCount(snapshot.data),
                    ));
                  }),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: LoadImage(
                              url: url,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        snapshot.data.checkStatus == true
                            ? Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorApp.colorGreen,
                                      border: Border.all(
                                          color: Colors.white, width: 2)),
                                ))
                            : Container()
                      ],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Text(
                                widget.user[Dbkeys.nickname],
                                style: TextStyleApp.textStyle500(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                              )),
                              const SizedBox(width: 10),
                              Text(
                                ConstChat.formatTime(
                                    widget.user[Dbkeys.lastLogin].toString(),
                                    TypeTime.milliseconds),
                                style: TextStyleApp.textStyle400(
                                    fontSize: 12, color: ColorApp.colorGrey90),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                ConstChat.convertTypeMessage(
                                    typeMessage: snapshot.data.type,
                                    content: snapshot.data.lastMessage),
                                style: TextStyleApp.textStyle400(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              )),
                              getCount(snapshot.data) > 0
                                  ? Container(
                                      margin: EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                          color: ColorApp.colorRed,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      alignment: Alignment.center,
                                      padding: getCount(snapshot.data)
                                                  .toString()
                                                  .length <
                                              3
                                          ? null
                                          : EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 2),
                                      width: getCount(snapshot.data)
                                                  .toString()
                                                  .length <
                                              3
                                          ? 20
                                          : null,
                                      height: getCount(snapshot.data)
                                                  .toString()
                                                  .length <
                                              3
                                          ? 20
                                          : null,
                                      child: Text(
                                        getCount(snapshot.data) < 99
                                            ? getCount(snapshot.data).toString()
                                            : "99+",
                                        style: TextStyleApp.textStyle400(
                                            color: Colors.white, fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
