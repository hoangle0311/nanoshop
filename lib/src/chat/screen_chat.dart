import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:media_info/media_info.dart';
import 'package:nanoshop/src/chat/text_style_chat.dart';
import 'package:nanoshop/src/chat/utils/color.dart';
import 'package:nanoshop/src/chat/utils/utils.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/entities/user_login/user_login.dart';
import '../injector.dart';
import 'config/Dbkeys.dart';
import 'config/Dbpaths.dart';
import 'config/Enum.dart';
import 'config/const_chat.dart';
import 'config/string_path.dart';
import 'firebase/firebase_account.dart';
import 'firebase/firebase_send_notifi.dart';
import 'item/MyElevatedButton.dart';
import 'item/bubble.dart';
import 'item/build_input_chat.dart';
import 'item/build_loading_chat.dart';
import 'item/build_message_chat.dart';
import 'item/build_temp_message.dart';
import 'models/data_model.dart';
import 'provider/Observer.dart';
import 'provider/currentchat_peer.dart';
import 'provider/seen_provider.dart';
import 'provider/seen_state.dart';
import 'config/optional_constants.dart';
import 'utils/chat_controller.dart';
import 'utils/deleteChatMedia.dart';
import 'utils/message.dart';
import 'utils/photo_view.dart';
import 'utils/save.dart';
import 'utils/uploadMediaWithProgress.dart';
import "package:collection/collection.dart";

class ModelChatScreen{
  String name;
  String currentUserNo,peerNo;
  DataModel? model;
  SharedPreferences? prefs;
  int count;
  ModelChatScreen({required this.name,required this.currentUserNo,required this.peerNo, this.model, this.prefs, this.count = 0});
}


hidekeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

class ScreenChat extends StatefulWidget {
  ModelChatScreen arguments;

  ScreenChat({required this.arguments});

  @override
  State<ScreenChat> createState() => _ScreenChatState();
}

class _ScreenChatState extends State<ScreenChat> with WidgetsBindingObserver {
  bool isgeneratingThumbnail = false;
  bool isemojiShowing = false;
  int? chatStatus;
  String? chatId;
  bool empty = true;
  bool isLoading = true;
  bool typing = false;
  bool isMessageLoading = true;
  String? peerAvatar, peerNo, currentUserNo, privateKey, sharedSecret;
  late DataModel _cachedModel;
  Map<String, dynamic>? peer, currentUser;
  late bool locked, hidden;
  SeenState? seenState;
  dynamic lastSeen;
  List<Map<String, dynamic>> _savedMessageDocs =
       List.from(<Map<String, dynamic>>[]);
  List<Message> messages = List.from(<Message>[]);
  TextEditingController textSend = TextEditingController();

  StreamSubscription? seenSubscription, msgSubscription, deleteUptoSubscription;
  bool isTyping = false;

  ImagePicker picker = ImagePicker();
  int? uploadTimestamp;
  int? thumnailtimestamp;
  late File thumbnailFile;
  String? videometadata;
  GlobalKey<State> _keyLoader =
      new GlobalKey<State>(debugLabel: 'qqqeqeqsseaadsqeqe');

  @override
  void initState() {
    super.initState();
    _cachedModel = widget.arguments.model!;
    peerNo = widget.arguments.peerNo;
    currentUserNo = widget.arguments.currentUserNo;
    Fiberchat.internetLookUp();
    updateLocalUserData(_cachedModel);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final observer = Provider.of<Observer>(this.context, listen: false);
      var currentpeer =
          Provider.of<CurrentChatPeer>(this.context, listen: false);
      currentpeer.setpeer(newpeerid: widget.arguments.peerNo);
      seenState = new SeenState(false);
      WidgetsBinding.instance!.addObserver(this);
      isLoading = false;
      chatId = '';
      textSend.addListener(() {
        if (textSend.text.isNotEmpty) {
          isTyping = true;
          setState(() {});
        } else {
          isTyping = false;
          setState(() {});
        }
      });
      loadSavedMessages();
      Future.delayed(const Duration(milliseconds: 00), () {
        readLocal(this.context);
        if (IsInterstitialAdShow == true && observer.isadmobshow == true) {}
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    setLastSeen();
    msgSubscription?.cancel();
    seenSubscription?.cancel();
    deleteUptoSubscription?.cancel();
  }

  readLocal(
    BuildContext context,
  ) async {
    try {
      seenState!.value = widget.arguments.prefs!.getInt(getLastSeenKey());
    } catch (e) {
      seenState!.value = false;
    }
    chatId = Fiberchat.getChatId(currentUserNo!, peerNo!);
    textSend.addListener(() {
      if (textSend.text.isNotEmpty && typing == false) {
        lastSeen = peerNo;
        FirebaseFirestore.instance
            .collection(DbPaths.collectionusers)
            .doc(currentUserNo)
            .update(
          {Dbkeys.lastSeen: peerNo},
        );
        typing = true;
      }
      if (textSend.text.isEmpty && typing == true) {
        lastSeen = true;
        FirebaseFirestore.instance
            .collection(DbPaths.collectionusers)
            .doc(currentUserNo)
            .update(
          {Dbkeys.lastSeen: true},
        );
        typing = false;
      }
    });
    loadMessagesAndListen();
  }

  String getLastSeenKey() {
    return "$peerNo-${Dbkeys.lastSeen}";
  }

  delete(int? ts) {
    setStateIfMounted(() {
      messages.removeWhere((msg) => msg.timestamp == ts);
      messages = List.from(messages);
    });
  }

  File? imageFile;

  updateDeleteBySenderField(int? ts, updateDoc, context) async {
    String url = await FireBaseAccount.getAvataUser(peerNo);
    setStateIfMounted(() {
      int i = messages.indexWhere((msg) => msg.timestamp == ts);
      var child = BuildTempMessage(
          context,
          MessageType.text,
          updateDoc[Dbkeys.content],
          updateDoc[Dbkeys.timestamp],
          true,
          updateDoc,
          currentUserNo,
          seenState,
          messages,
        url,
      );
      var timestamp = messages[i].timestamp;
      var from = messages[i].from;
      // var onTap = messages[i].onTap;
      var onDoubleTap = messages[i].onDoubleTap;
      var onDismiss = messages[i].onDismiss;
      var onLongPress = () {};
      if (i >= 0) {
        messages.removeWhere((msg) => msg.timestamp == ts);
        messages.insert(
            i,
            Message(child,
                timestamp: timestamp,
                from: from,
                onTap: () {},
                onDoubleTap: onDoubleTap,
                onDismiss: onDismiss,
                onLongPress: onLongPress));
      }
      messages = List.from(messages);
    });
  }

  contextMenuNew(BuildContext context, Map<String, dynamic> doc, bool isTemp,
      {bool saved = false}) {
    List<Widget> tiles = List.from(<Widget>[]);
    //####################----------------------- Delete Msgs for SENDER ---------------------------------------------------
    if ((doc[Dbkeys.from] == currentUserNo &&
            doc[Dbkeys.hasSenderDeleted] == false) &&
        saved == false) {
      tiles.add(ListTile(
          dense: true,
          leading: Icon(Icons.delete_outline),
          title: Text(
            delete_for_me,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: () async {
            Fiberchat.toast(deleting);
            await FirebaseFirestore.instance
                .collection(DbPaths.collectionmessages)
                .doc(chatId)
                .collection(chatId!)
                .doc('${doc[Dbkeys.timestamp]}')
                .get()
                .then((chatDoc) async {
              if (!chatDoc.exists) {
                Fiberchat.toast(readload);
              } else if (chatDoc.exists) {
                Map<String, dynamic> realtimeDoc = chatDoc.data()!;
                if (realtimeDoc[Dbkeys.hasRecipientDeleted] == true) {
                  if ((doc.containsKey(Dbkeys.isbroadcast) == true
                          ? doc[Dbkeys.isbroadcast]
                          : false) ==
                      true) {
                    // -------Delete broadcast message completely as recipient has already deleted
                    await FirebaseFirestore.instance
                        .collection(DbPaths.collectionmessages)
                        .doc(chatId)
                        .collection(chatId!)
                        .doc('${realtimeDoc[Dbkeys.timestamp]}')
                        .delete();
                    delete(realtimeDoc[Dbkeys.timestamp]);
                    Save.deleteMessage(peerNo, realtimeDoc);
                    _savedMessageDocs.removeWhere((msg) =>
                        msg[Dbkeys.timestamp] == doc[Dbkeys.timestamp]);
                    setStateIfMounted(() {
                      _savedMessageDocs = List.from(_savedMessageDocs);
                    });
                    Future.delayed(const Duration(milliseconds: 300), () {
                      Navigator.maybePop(this.context);
                      Fiberchat.toast(deleted_toast);
                      hidekeyboard(context);
                    });
                  } else {
                    // -------Delete message completely as recipient has already deleted
                    await deleteMsgMedia(realtimeDoc, chatId!)
                        .then((isDeleted) async {
                      if (isDeleted == false || isDeleted == null) {
                        Fiberchat.toast(err_delete);
                      } else {
                        await FirebaseFirestore.instance
                            .collection(DbPaths.collectionmessages)
                            .doc(chatId)
                            .collection(chatId!)
                            .doc('${realtimeDoc[Dbkeys.timestamp]}')
                            .delete();
                        delete(realtimeDoc[Dbkeys.timestamp]);
                        Save.deleteMessage(peerNo, realtimeDoc);
                        _savedMessageDocs.removeWhere((msg) =>
                            msg[Dbkeys.timestamp] == doc[Dbkeys.timestamp]);
                        setStateIfMounted(() {
                          _savedMessageDocs = List.from(_savedMessageDocs);
                        });
                        Future.delayed(const Duration(milliseconds: 300), () {
                          Navigator.maybePop(this.context);
                          Fiberchat.toast(deleted_toast);
                          hidekeyboard(context);
                        });
                      }
                    });
                  }
                } else {
                  //----Don't Delete Media from server, as recipient has not deleted the message from thier message list-----
                  FirebaseFirestore.instance
                      .collection(DbPaths.collectionmessages)
                      .doc(chatId)
                      .collection(chatId!)
                      .doc('${realtimeDoc[Dbkeys.timestamp]}')
                      .set({Dbkeys.hasSenderDeleted: true},
                          SetOptions(merge: true));

                  Save.deleteMessage(peerNo, doc);
                  _savedMessageDocs.removeWhere(
                      (msg) => msg[Dbkeys.timestamp] == doc[Dbkeys.timestamp]);
                  setStateIfMounted(() {
                    _savedMessageDocs = List.from(_savedMessageDocs);
                  });

                  Map<String, dynamic> tempDoc = realtimeDoc;
                  setStateIfMounted(() {
                    tempDoc[Dbkeys.hasSenderDeleted] = true;
                  });
                  updateDeleteBySenderField(
                      realtimeDoc[Dbkeys.timestamp], tempDoc, context);

                  Future.delayed(const Duration(milliseconds: 300), () {
                    Navigator.maybePop(this.context);
                    Fiberchat.toast(deleted_toast);
                    hidekeyboard(context);
                  });
                }
              }
            });
          }));

      tiles.add(ListTile(
          dense: true,
          leading: Icon(Icons.delete),
          title: Text(
            delete_all,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: () async {
            if ((doc.containsKey(Dbkeys.isbroadcast) == true
                    ? doc[Dbkeys.isbroadcast]
                    : false) ==
                true) {
              // -------Delete broadcast message completely for everyone
              await FirebaseFirestore.instance
                  .collection(DbPaths.collectionmessages)
                  .doc(chatId)
                  .collection(chatId!)
                  .doc('${doc[Dbkeys.timestamp]}')
                  .delete();
              delete(doc[Dbkeys.timestamp]);
              Save.deleteMessage(peerNo, doc);
              _savedMessageDocs.removeWhere(
                  (msg) => msg[Dbkeys.timestamp] == doc[Dbkeys.timestamp]);
              setStateIfMounted(() {
                _savedMessageDocs = List.from(_savedMessageDocs);
              });
              Future.delayed(const Duration(milliseconds: 300), () {
                Navigator.maybePop(this.context);
                Fiberchat.toast(deleted_toast);
                hidekeyboard(context);
              });
            } else {
              // -------Delete message completely for everyone
              Fiberchat.toast(deleting);
              await deleteMsgMedia(doc, chatId!).then((isDeleted) async {
                if (isDeleted == false || isDeleted == null) {
                  Fiberchat.toast(err_delete);
                } else {
                  await FirebaseFirestore.instance
                      .collection(DbPaths.collectionmessages)
                      .doc(chatId)
                      .collection(chatId!)
                      .doc('${doc[Dbkeys.timestamp]}')
                      .delete();
                  delete(doc[Dbkeys.timestamp]);
                  Save.deleteMessage(peerNo, doc);
                  _savedMessageDocs.removeWhere(
                      (msg) => msg[Dbkeys.timestamp] == doc[Dbkeys.timestamp]);
                  setStateIfMounted(() {
                    _savedMessageDocs = List.from(_savedMessageDocs);
                  });
                  Future.delayed(const Duration(milliseconds: 300), () {
                    Navigator.maybePop(this.context);
                    Fiberchat.toast(deleted_toast);
                    hidekeyboard(context);
                  });
                }
              });
            }
          }));
    }
    //####################-------------------- Delete Msgs for RECIPIENTS---------------------------------------------------
    if ((doc[Dbkeys.to] == currentUserNo &&
            doc[Dbkeys.hasRecipientDeleted] == false) &&
        saved == false) {
      tiles.add(ListTile(
          dense: true,
          leading: Icon(Icons.delete_outline),
          title: Text(
            delete_for_me,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: () async {
            Fiberchat.toast(
              deleting,
            );
            await FirebaseFirestore.instance
                .collection(DbPaths.collectionmessages)
                .doc(chatId)
                .collection(chatId!)
                .doc('${doc[Dbkeys.timestamp]}')
                .get()
                .then((chatDoc) async {
              if (!chatDoc.exists) {
                Fiberchat.toast(readload);
              } else if (chatDoc.exists) {
                Map<String, dynamic> realtimeDoc = chatDoc.data()!;
                if (realtimeDoc[Dbkeys.hasSenderDeleted] == true) {
                  if ((doc.containsKey(Dbkeys.isbroadcast) == true
                          ? doc[Dbkeys.isbroadcast]
                          : false) ==
                      true) {
                    // -------Delete broadcast message completely as sender has already deleted
                    await FirebaseFirestore.instance
                        .collection(DbPaths.collectionmessages)
                        .doc(chatId)
                        .collection(chatId!)
                        .doc('${realtimeDoc[Dbkeys.timestamp]}')
                        .delete();
                    delete(realtimeDoc[Dbkeys.timestamp]);
                    Save.deleteMessage(peerNo, realtimeDoc);
                    _savedMessageDocs.removeWhere((msg) =>
                        msg[Dbkeys.timestamp] == doc[Dbkeys.timestamp]);
                    setStateIfMounted(() {
                      _savedMessageDocs = List.from(_savedMessageDocs);
                    });
                    Future.delayed(const Duration(milliseconds: 300), () {
                      Navigator.maybePop(this.context);
                      Fiberchat.toast(deleted_toast);
                      hidekeyboard(context);
                    });
                  } else {
                    // -------Delete message completely as sender has already deleted
                    await deleteMsgMedia(realtimeDoc, chatId!)
                        .then((isDeleted) async {
                      if (isDeleted == false || isDeleted == null) {
                        Fiberchat.toast(err_delete);
                      } else {
                        await FirebaseFirestore.instance
                            .collection(DbPaths.collectionmessages)
                            .doc(chatId)
                            .collection(chatId!)
                            .doc('${realtimeDoc[Dbkeys.timestamp]}')
                            .delete();
                        delete(realtimeDoc[Dbkeys.timestamp]);
                        Save.deleteMessage(peerNo, realtimeDoc);
                        _savedMessageDocs.removeWhere((msg) =>
                            msg[Dbkeys.timestamp] == doc[Dbkeys.timestamp]);
                        setStateIfMounted(() {
                          _savedMessageDocs = List.from(_savedMessageDocs);
                        });
                        Future.delayed(const Duration(milliseconds: 300), () {
                          Navigator.maybePop(this.context);
                          Fiberchat.toast(deleted_toast);
                          hidekeyboard(context);
                        });
                      }
                    });
                  }
                } else {
                  //----Don't Delete Media from server, as recipient has not deleted the message from thier message list-----
                  FirebaseFirestore.instance
                      .collection(DbPaths.collectionmessages)
                      .doc(chatId)
                      .collection(chatId!)
                      .doc('${realtimeDoc[Dbkeys.timestamp]}')
                      .set({Dbkeys.hasRecipientDeleted: true},
                          SetOptions(merge: true));

                  Save.deleteMessage(peerNo, doc);
                  _savedMessageDocs.removeWhere(
                      (msg) => msg[Dbkeys.timestamp] == doc[Dbkeys.timestamp]);
                  setStateIfMounted(() {
                    _savedMessageDocs = List.from(_savedMessageDocs);
                  });
                  if (isTemp == true) {
                    Map<String, dynamic> tempDoc = realtimeDoc;
                    setStateIfMounted(() {
                      tempDoc[Dbkeys.hasRecipientDeleted] = true;
                    });
                    updateDeleteBySenderField(
                        realtimeDoc[Dbkeys.timestamp], tempDoc, context);
                  }
                  Future.delayed(const Duration(milliseconds: 300), () {
                    Navigator.maybePop(this.context);
                    Fiberchat.toast(deleted_toast);
                    hidekeyboard(context);
                  });
                }
              }
            });
          }));
    }
    if (doc.containsKey(Dbkeys.broadcastID) &&
        doc[Dbkeys.to] == widget.arguments.currentUserNo) {
      tiles.add(ListTile(
          dense: true,
          leading: Icon(Icons.block),
          title: Text(
            block_broadcast,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Fiberchat.toast(
              plswait,
            );
            Future.delayed(const Duration(milliseconds: 200), () {
              FirebaseFirestore.instance
                  .collection(DbPaths.collectionbroadcasts)
                  .doc(doc[Dbkeys.broadcastID])
                  .update({
                Dbkeys.broadcastMEMBERSLIST:
                    FieldValue.arrayRemove([widget.arguments.currentUserNo]),
                Dbkeys.broadcastBLACKLISTED:
                    FieldValue.arrayUnion([widget.arguments.currentUserNo]),
              }).then((value) {
                Navigator.pop(context);
                hidekeyboard(context);
                Fiberchat.toast(block_broadcast);
              }).catchError((error) {
                Navigator.pop(context);
                Fiberchat.toast(error.toString() + "lỗi gì đây");
                hidekeyboard(context);
              });
            });
          }));
    }

    //####################--------------------- ALL BELOW DIALOG TILES FOR COMMON SENDER & RECIPIENT-------------------------###########################------------------------------
    if (((doc[Dbkeys.from] == currentUserNo &&
                doc[Dbkeys.hasSenderDeleted] == false) ||
            (doc[Dbkeys.to] == currentUserNo &&
                doc[Dbkeys.hasRecipientDeleted] == false)) &&
        saved == false) {
      tiles.add(ListTile(
          dense: true,
          leading: Icon(Icons.save_outlined),
          title: Text(
            save_string,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            save(doc);
            hidekeyboard(context);
            Navigator.pop(context);
          }));
    }
    if (doc[Dbkeys.messageType] == MessageType.text.index &&
        !doc.containsKey(Dbkeys.broadcastID)) {
      tiles.add(ListTile(
          dense: true,
          leading: Icon(Icons.content_copy),
          title: Text(
            copy,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Clipboard.setData(ClipboardData(text: doc[Dbkeys.content]));
            Navigator.pop(context);
            hidekeyboard(context);
            Fiberchat.toast(copied);
          }));
    }

    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(children: tiles);
        });
  }

  save(Map<String, dynamic> doc) async {
    Fiberchat.toast(
      saved,
    );
    if (!_savedMessageDocs
        .any((_doc) => _doc[Dbkeys.timestamp] == doc[Dbkeys.timestamp])) {
      String? content;
      if (doc[Dbkeys.messageType] == MessageType.image.index) {
        content = doc[Dbkeys.content].toString().startsWith('http')
            ? await Save.getBase64FromImage(
                imageUrl: doc[Dbkeys.content] as String?)
            : doc[Dbkeys
                .content]; // if not a url, it is a base64 from saved messages
      } else {
        // If text
        content = doc[Dbkeys.content];
      }
      doc[Dbkeys.content] = content;
      Save.saveMessage(peerNo, doc);
      _savedMessageDocs.add(doc);
      setStateIfMounted(() {
        _savedMessageDocs = List.from(_savedMessageDocs);
      });
    }
  }

  contextMenuOld(BuildContext context, Map<String, dynamic> doc,
      {bool saved = false}) {
    List<Widget> tiles = List.from(<Widget>[]);
    if (saved == false && !doc.containsKey(Dbkeys.broadcastID)) {
      tiles.add(ListTile(
          dense: true,
          leading: Icon(Icons.save_outlined),
          title: Text(
            save_string,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            save(doc);
            hidekeyboard(context);
            Navigator.pop(context);
          }));
    }
    if ((doc[Dbkeys.from] != currentUserNo) && saved == false) {
      tiles.add(ListTile(
          dense: true,
          leading: Icon(Icons.delete),
          title: Text(
            delete_for_me,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: () async {
            await FirebaseFirestore.instance
                .collection(DbPaths.collectionmessages)
                .doc(chatId)
                .collection(chatId!)
                .doc('${doc[Dbkeys.timestamp]}')
                .update({Dbkeys.hasRecipientDeleted: true});
            Save.deleteMessage(peerNo, doc);
            _savedMessageDocs.removeWhere(
                (msg) => msg[Dbkeys.timestamp] == doc[Dbkeys.timestamp]);
            setStateIfMounted(() {
              _savedMessageDocs = List.from(_savedMessageDocs);
            });

            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.maybePop(this.context);
              Fiberchat.toast(deleted_toast);
            });
          }));
    }

    if (doc[Dbkeys.messageType] == MessageType.text.index) {
      tiles.add(ListTile(
          dense: true,
          leading: Icon(Icons.content_copy),
          title: Text(
            copy,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Clipboard.setData(ClipboardData(text: doc[Dbkeys.content]));
            Navigator.pop(context);
            Fiberchat.toast(copied);
          }));
    }
    if (doc.containsKey(Dbkeys.broadcastID) &&
        doc[Dbkeys.to] == widget.arguments.currentUserNo) {
      tiles.add(ListTile(
          dense: true,
          leading: Icon(Icons.block),
          title: Text(
            block_broadcast,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Fiberchat.toast(
              plswait,
            );
            Future.delayed(const Duration(milliseconds: 500), () {
              FirebaseFirestore.instance
                  .collection(DbPaths.collectionbroadcasts)
                  .doc(doc[Dbkeys.broadcastID])
                  .update({
                Dbkeys.broadcastMEMBERSLIST:
                    FieldValue.arrayRemove([widget.arguments.currentUserNo]),
                Dbkeys.broadcastBLACKLISTED:
                    FieldValue.arrayUnion([widget.arguments.currentUserNo]),
              }).then((value) {
                Fiberchat.toast(
                  block_broadcast,
                );
                hidekeyboard(context);
                Navigator.pop(context);
              }).catchError((error) {
                Fiberchat.toast(block_broadcast);
                Navigator.pop(context);
                hidekeyboard(context);
              });
            });
          }));
    }
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(children: tiles);
        });
  }

  loadMessagesAndListen() async {
    setStateIfMounted(() {
      isLoading = true;
    });
    String url = await FireBaseAccount.getAvataUser(peerNo);
    await FirebaseFirestore.instance
        .collection(DbPaths.collectionmessages)
        .doc(chatId)
        .collection(chatId!)
        .orderBy(Dbkeys.timestamp)
        .get()
        .then((docs) {
      if (docs.docs.isNotEmpty) {
        empty = false;
        docs.docs.forEach((doc) {
          Map<String, dynamic> _doc = Map.from(doc.data());
          int? ts = _doc[Dbkeys.timestamp];
          messages.add(Message(
              BuildMessage(
                context,
                _doc,
                cachedModel: _cachedModel,
                seenState: seenState,
                peerNo: peerNo,
                messages: messages,
                currentUserNo: currentUserNo,
                urlAvatar: url
              ),
              onDismiss: _doc[Dbkeys.from] == peerNo
                  ? () {
                      if (_doc.containsKey(Dbkeys.hasRecipientDeleted) &&
                          _doc.containsKey(Dbkeys.hasSenderDeleted)) {
                        contextMenuNew(context, _doc, false);
                      } else {
                        contextMenuOld(context, _doc);
                      }
                    }
                  : null,
              onTap: (_doc[Dbkeys.from] == widget.arguments.currentUserNo &&
                          _doc[Dbkeys.hasSenderDeleted] == true) ==
                      true
                  ? () {}
                  : _doc[Dbkeys.messageType] == MessageType.image.index
                      ? () {
                          print('aaa1');
                          Navigator.push(
                              this.context,
                              MaterialPageRoute(
                                builder: (context) => PhotoViewWrapper(
                                  message: _doc[Dbkeys.content],
                                  tag: ts.toString(),
                                  imageProvider: CachedNetworkImageProvider(
                                      _doc[Dbkeys.content]),
                                ),
                              ));
                        }
                      : null,
              onDoubleTap: _doc.containsKey(Dbkeys.broadcastID)
                  ? () {}
                  : () {
                      save(_doc);
                    }, onLongPress: () {
            if (_doc.containsKey(Dbkeys.hasRecipientDeleted) &&
                _doc.containsKey(Dbkeys.hasSenderDeleted)) {
              if ((_doc[Dbkeys.from] == widget.arguments.currentUserNo &&
                      _doc[Dbkeys.hasSenderDeleted] == true) ==
                  false) {
                //--Show Menu only if message is not deleted by current user already
                contextMenuNew(this.context, _doc, false);
              }
            } else {
              contextMenuOld(this.context, _doc);
            }
          }, from: _doc[Dbkeys.from], timestamp: ts));
          if (doc.data()[Dbkeys.timestamp] ==
              docs.docs.last.data()[Dbkeys.timestamp]) {
            setStateIfMounted(() {
              isMessageLoading = false;
              print(loadAllMes);
              isLoading = false;
            });
          }
        });
      } else {
        setStateIfMounted(() {
          isMessageLoading = false;
          print(loadAllMes);
          isLoading = false;
        });
      }
      if (mounted) {
        setStateIfMounted(() {
          messages = List.from(messages);
          isLoading = false;
        });
      }
      msgSubscription = FirebaseFirestore.instance
          .collection(DbPaths.collectionmessages)
          .doc(chatId)
          .collection(chatId!)
          .where(Dbkeys.from, isEqualTo: peerNo)
          .snapshots()
          .listen((query) {
        if (empty == true || query.docs.length != query.docChanges.length) {
          //----below action triggers when peer new message arrives
          query.docChanges.where((doc) {
            return doc.oldIndex <= doc.newIndex &&
                doc.type == DocumentChangeType.added;

            //  &&
            //     query.docs[doc.oldIndex][Dbkeys.timestamp] !=
            //         query.docs[doc.newIndex][Dbkeys.timestamp];
          }).forEach((change) {
            Map<String, dynamic> _doc = Map.from(change.doc.data()!);
            int? ts = _doc[Dbkeys.timestamp];
            // _doc[Dbkeys.content] = decryptWithCRC(_doc[Dbkeys.content]);

            messages.add(Message(
              BuildMessage(
                context,
                _doc,
                cachedModel: _cachedModel,
                seenState: seenState,
                peerNo: peerNo,
                messages: messages,
                currentUserNo: currentUserNo,
              urlAvatar: url
              ),
              onLongPress: () {
                if (_doc.containsKey(Dbkeys.hasRecipientDeleted) &&
                    _doc.containsKey(Dbkeys.hasSenderDeleted)) {
                  if ((_doc[Dbkeys.from] == widget.arguments.currentUserNo &&
                          _doc[Dbkeys.hasSenderDeleted] == true) ==
                      false) {
                    //--Show Menu only if message is not deleted by current user already
                    contextMenuNew(this.context, _doc, false);
                  }
                } else {
                  contextMenuOld(this.context, _doc);
                }
              },
              onTap: (_doc[Dbkeys.from] == widget.arguments.currentUserNo &&
                          _doc[Dbkeys.hasSenderDeleted] == true) ==
                      true
                  ? () {}
                  : _doc[Dbkeys.messageType] == MessageType.image.index
                      ? () {
                          print('aaa2');
                          Navigator.push(
                              this.context,
                              MaterialPageRoute(
                                builder: (context) => PhotoViewWrapper(
                                  message: _doc[Dbkeys.content],
                                  tag: ts.toString(),
                                  imageProvider: CachedNetworkImageProvider(
                                      _doc[Dbkeys.content]),
                                ),
                              ));
                        }
                      : null,
              onDoubleTap: _doc.containsKey(Dbkeys.broadcastID)
                  ? () {}
                  : () {
                      save(_doc);
                    },
              from: _doc[Dbkeys.from],
              timestamp: ts,
              onDismiss: () {
                if (_doc.containsKey(Dbkeys.hasRecipientDeleted) &&
                    _doc.containsKey(Dbkeys.hasSenderDeleted)) {
                  contextMenuNew(context, _doc, false);
                } else {
                  contextMenuOld(context, _doc);
                }
              },
            ));
          });
          //----below action triggers when peer message get deleted
          query.docChanges.where((doc) {
            return doc.type == DocumentChangeType.removed;
          }).forEach((change) {
            Map<String, dynamic> _doc = Map.from(change.doc.data()!);

            int i = messages.indexWhere(
                (element) => element.timestamp == _doc[Dbkeys.timestamp]);
            if (i >= 0) messages.removeAt(i);
            Save.deleteMessage(peerNo, _doc);
            _savedMessageDocs.removeWhere(
                (msg) => msg[Dbkeys.timestamp] == _doc[Dbkeys.timestamp]);
            setStateIfMounted(() {
              _savedMessageDocs = List.from(_savedMessageDocs);
            });
          }); //----below action triggers when peer message gets modified
          query.docChanges.where((doc) {
            return doc.type == DocumentChangeType.modified;
          }).forEach((change) {
            Map<String, dynamic> _doc = Map.from(change.doc.data()!);

            int i = messages.indexWhere(
                (element) => element.timestamp == _doc[Dbkeys.timestamp]);
            if (i >= 0) {
              messages.removeAt(i);
              setStateIfMounted(() {});
              int? ts = _doc[Dbkeys.timestamp];
              //_doc[Dbkeys.content] = decryptWithCRC(_doc[Dbkeys.content]);
              messages.insert(
                  i,
                  Message(
                    BuildMessage(
                      context,
                      _doc,
                      cachedModel: _cachedModel,
                      seenState: seenState,
                      peerNo: peerNo,
                      messages: messages,
                      currentUserNo: currentUserNo,
                      urlAvatar: url,
                    ),
                    onLongPress: () {
                      if (_doc.containsKey(Dbkeys.hasRecipientDeleted) &&
                          _doc.containsKey(Dbkeys.hasSenderDeleted)) {
                        if ((_doc[Dbkeys.from] ==
                                    widget.arguments.currentUserNo &&
                                _doc[Dbkeys.hasSenderDeleted] == true) ==
                            false) {
                          //--Show Menu only if message is not deleted by current user already
                          contextMenuNew(this.context, _doc, false);
                        }
                      } else {
                        contextMenuOld(this.context, _doc);
                      }
                    },
                    onTap: (_doc[Dbkeys.from] ==
                                    widget.arguments.currentUserNo &&
                                _doc[Dbkeys.hasSenderDeleted] == true) ==
                            true
                        ? () {}
                        : _doc[Dbkeys.messageType] == MessageType.image.index
                            ? () {
                                print('aaa3');
                                Navigator.push(
                                    this.context,
                                    MaterialPageRoute(
                                      builder: (context) => PhotoViewWrapper(
                                        message: _doc[Dbkeys.content],
                                        tag: ts.toString(),
                                        imageProvider:
                                            CachedNetworkImageProvider(
                                                _doc[Dbkeys.content]),
                                      ),
                                    ));
                              }
                            : null,
                    onDoubleTap: _doc.containsKey(Dbkeys.broadcastID)
                        ? () {}
                        : () {
                            save(_doc);
                          },
                    from: _doc[Dbkeys.from],
                    timestamp: ts,
                    onDismiss: () {
                      if (_doc.containsKey(Dbkeys.hasRecipientDeleted) &&
                          _doc.containsKey(Dbkeys.hasSenderDeleted)) {
                        contextMenuNew(context, _doc, false);
                      } else {
                        contextMenuOld(context, _doc);
                      }
                    },
                  ));
            }
          });
          if (mounted) {
            setStateIfMounted(() {
              messages = List.from(messages);
            });
          }
        }
      });
    });
  }

  updateLocalUserData(DataModel model) {
    currentUser = _cachedModel.currentUser;
    peer = model.userData[peerNo];
    if (currentUser != null && peer != null) {
      hidden = currentUser![Dbkeys.hidden] != null &&
          currentUser![Dbkeys.hidden].contains(peerNo);
      locked = currentUser![Dbkeys.locked] != null &&
          currentUser![Dbkeys.locked].contains(peerNo);
      chatStatus = peer![Dbkeys.chatStatus];
      peerAvatar = peer![Dbkeys.photoUrl];
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed)
      setOnline();
    else
      setLastSeen();
  }

  void setOnline() async {
    await FireBaseAccount.updateUser({"status": true}, injector<UserLogin>());
  }

  void setLastSeen() async {
    if (chatStatus != ChatStatus.blocked.index) {
      if (chatId != null) {
        await FirebaseFirestore.instance
            .collection(DbPaths.collectionmessages)
            .doc(chatId)
            .set({'$currentUserNo': DateTime.now().millisecondsSinceEpoch},
                SetOptions(merge: true));
      }
    }
  }

  void setLastMessage({required int type, String? text}) async {
    await FirebaseFirestore.instance
        .collection(DbPaths.collectionmessages)
        .doc(chatId)
        .set({
      Dbkeys.lastMessage: text,
      Dbkeys.groupTYPE: type,
    }, SetOptions(merge: true));
  }

  void loadSavedMessages() {
    if (_savedMessageDocs.isEmpty) {
      Save.getSavedMessages(peerNo).then((_msgDocs) {
        if (_msgDocs != null) {
          setStateIfMounted(() {
            _savedMessageDocs = _msgDocs;
          });
        }
      });
    }
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  refreshInput() {
    setStateIfMounted(() {
      if (isemojiShowing == false) {
        // hidekeyboard(this.context);
        keyboardFocusNode.unfocus();
        isemojiShowing = true;
      } else {
        isemojiShowing = false;
        keyboardFocusNode.requestFocus();
      }
    });
  }

  getImage(File image) {
    final observer = Provider.of<Observer>(this.context, listen: false);
    // ignore: unnecessary_null_comparison
  }

  Future uploadFileWithProgressIndicator(bool isthumbnail) async {
    uploadTimestamp = DateTime.now().millisecondsSinceEpoch;
    String fileName = getFileName(
        currentUserNo,
        isthumbnail == false
            ? '$uploadTimestamp'
            : '${thumnailtimestamp}Thumbnail');
    Reference reference =
        FirebaseStorage.instance.ref("+00_CHAT_MEDIA/$chatId/").child(fileName);
    UploadTask uploading =
        reference.putFile(isthumbnail == true ? thumbnailFile : imageFile!);

    showDialog<void>(
        context: this.context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              // side: BorderSide(width: 5, color: Colors.green)),
              key: _keyLoader,
              backgroundColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              children: <Widget>[
                Center(
                  child: StreamBuilder(
                      stream: uploading.snapshotEvents,
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasData) {
                          final TaskSnapshot snap = uploading.snapshot;
                          return openUploadDialog(
                            context: context,
                            percent: bytesTransferred(snap) / 100,
                            title: isthumbnail == true
                                ? generatingthumbnail
                                : uploading_toast,
                            subtitle:
                                "${((((snap.bytesTransferred / 1024) / 1000) * 100).roundToDouble()) / 100}/${((((snap.totalBytes / 1024) / 1000) * 100).roundToDouble()) / 100} MB",
                          );
                        } else {
                          return openUploadDialog(
                            context: context,
                            percent: 0.0,
                            title: isthumbnail == true
                                ? generatingthumbnail
                                : uploading_toast,
                            subtitle: '',
                          );
                        }
                      }),
                ),
              ],
            ),
          );
        });

    TaskSnapshot downloadTask = await uploading;
    String downloadedurl = await downloadTask.ref.getDownloadURL();

    if (isthumbnail == false) {
      setStateIfMounted(() {
        thumnailtimestamp = uploadTimestamp;
      });
    }
    if (isthumbnail == true) {
      MediaInfo _mediaInfo = MediaInfo();

      await _mediaInfo.getMediaInfo(thumbnailFile.path).then((mediaInfo) {
        setStateIfMounted(() {
          videometadata = jsonEncode({
            "width": mediaInfo['width'],
            "height": mediaInfo['height'],
            "orientation": null,
            "duration": mediaInfo['durationMs'],
            "filesize": null,
            "author": null,
            "date": null,
            "framerate": null,
            "location": null,
            "path": null,
            "title": '',
            "mimetype": mediaInfo['mimeType'],
          }).toString();
        });
      }).catchError((onError) {
        // Fiberchat.toast('Sending failed !');
        print('ERROR SENDING FILE: $onError');
      });
    } else {
      FirebaseFirestore.instance
          .collection(DbPaths.collectionusers)
          .doc(widget.arguments.currentUserNo)
          .set({
        Dbkeys.mssgSent: FieldValue.increment(1),
      }, SetOptions(merge: true));
      FirebaseFirestore.instance
          .collection(DbPaths.collectiondashboard)
          .doc(DbPaths.docchatdata)
          .set({
        Dbkeys.mediamessagessent: FieldValue.increment(1),
      }, SetOptions(merge: true));
    }
    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop(); //
    return downloadedurl;
  }

  void onSendMessage(BuildContext context, String content, MessageType type,
      int? timestamp) async {
    String url = await FireBaseAccount.getAvataUser(peerNo);
    if (content.trim() != '') {
      try {
        content = content.trim();
        if (chatStatus == null || chatStatus == 4)
          ChatController.request(
            currentUserNo,
            peerNo,
            chatId,
          );
        textSend.clear();
        if (content is String) {
          var tempDoc = {
            Dbkeys.timestamp: timestamp,
            Dbkeys.to: peerNo,
            Dbkeys.messageType: type.index,
            Dbkeys.content: content,
            Dbkeys.from: currentUserNo,
            Dbkeys.hasSenderDeleted: false,
            Dbkeys.hasRecipientDeleted: false,
            Dbkeys.sendername: _cachedModel.currentUser![Dbkeys.nickname],
          };
          Future messaging = FirebaseFirestore.instance
              .collection(DbPaths.collectionmessages)
              .doc(chatId)
              .collection(chatId!)
              .doc('$timestamp')
              .set(tempDoc, SetOptions(merge: true));
          _cachedModel.addMessage(peerNo, timestamp, messaging);
          setLastMessage(type: type.index, text: content);
          FirebaseSendNotifi.sendNotifi(
              title: "${_cachedModel.currentUser![Dbkeys.nickname]}",
              id_send: peerNo,
              body:ConstChat.convertTypeMessage(typeMessage: type.index,content: content),
              data: tempDoc);
          setStateIfMounted(() {
            messages = List.from(messages)
              ..add(Message(
                BuildTempMessage(context, type, content, timestamp, messaging,
                    tempDoc, currentUserNo, seenState, messages,url),
                onTap:
                    (tempDoc[Dbkeys.from] == widget.arguments.currentUserNo &&
                                tempDoc[Dbkeys.hasSenderDeleted] == true) ==
                            true
                        ? () {}
                        : type == MessageType.image
                            ? () {
                                print('aaa5');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PhotoViewWrapper(
                                        message: content,
                                        tag: timestamp.toString(),
                                        imageProvider:
                                            CachedNetworkImageProvider(content),
                                      ),
                                    ));
                              }
                            : null,
                onDismiss: null,
                onDoubleTap: () {
                  // save(tempDoc);
                },
                onLongPress: () {
                  if (tempDoc.containsKey(Dbkeys.hasRecipientDeleted) &&
                      tempDoc.containsKey(Dbkeys.hasSenderDeleted)) {
                    if ((tempDoc[Dbkeys.from] ==
                                widget.arguments.currentUserNo &&
                            tempDoc[Dbkeys.hasSenderDeleted] == true) ==
                        false) {
                      //--Show Menu only if message is not deleted by current user already
                      contextMenuNew(this.context, tempDoc, true);
                    }
                  } else {
                    contextMenuOld(context, tempDoc);
                  }
                },
                from: currentUserNo,
                timestamp: timestamp,
              ));
          });

          unawaited(realtime.animateTo(0.0,
              duration: Duration(milliseconds: 300), curve: Curves.easeOut));
          // _playPopSound();
        } else {
          Fiberchat.toast(no_chat);
        }
      } on Exception catch (_) {
        print('Đã bắt được ngoại lệ!');
      }
    }
  }

  final ScrollController realtime = new ScrollController();

  FocusNode keyboardFocusNode = new FocusNode();

  bool isBlocked() {
    return chatStatus == ChatStatus.blocked.index;
  }

  Widget buildMessages(
    BuildContext context,
  ) {
    if (chatStatus == ChatStatus.blocked.index) {
      return AlertDialog(
        backgroundColor: Colors.white,
        elevation: 10.0,
        title: Text(
          'Mở khóa' + ' ${peer![Dbkeys.nickname]}?',
          style: TextStyle(color: fiberchatBlack),
        ),
        actions: <Widget>[
          myElevatedButton(
              color: fiberchatWhite,
              child: Text(
                'Hủy bỏ',
                style: TextStyle(color: fiberchatBlack),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          myElevatedButton(
              color: fiberchatLightGreen,
              child: Text(
                'Mở khóa',
                style: TextStyle(color: fiberchatWhite),
              ),
              onPressed: () {
                ChatController.accept(currentUserNo, peerNo);
                setStateIfMounted(() {
                  chatStatus = ChatStatus.accepted.index;
                });
              })
        ],
      );
    }
    return Flexible(
        child: messages.isNotEmpty ? ListView(
      padding: EdgeInsets.all(10.0),
      children: getGroupedMessages(),
      controller: realtime,
      reverse: true,
    ) : Center(child: Text(
          isLoading ? "" : "Danh sách trống",
          textAlign: TextAlign.center,
          style: TextStyleApp.textStyle600(),
        ),)) ;
  }

  List<Widget> getGroupedMessages() {
    List<Widget> _groupedMessages = [];
    int count = 0;
    groupBy<Message, String>(messages, (msg) {
      return getWhen(DateTime.fromMillisecondsSinceEpoch(msg.timestamp!));
    }).forEach(
      (when, _actualMessages) {
        _groupedMessages.add(
          Center(
            child: Chip(
              backgroundColor: Colors.blue[50],
              label: Text(
                when,
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ),
          ),
        );
        _actualMessages.forEach(
          (msg) {
            count++;
            if (widget.arguments.count != 0 &&
                (messages.length - count) == widget.arguments.count - 1) {
              _groupedMessages.add(
                Center(
                  child: Chip(
                    backgroundColor: Colors.blue[50],
                    label: Text(
                      '${widget.arguments.count} $unread',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  ),
                ),
              );
              widget.arguments.count = 0; // reset
            }
            _groupedMessages.add(msg.child);
          },
        );
      },
    );
    return _groupedMessages.reversed.toList();
  }

  getWhen(date) {
    DateTime now = DateTime.now();
    String when;
    if (date.day == now.day)
      when = 'Hôm nay';
    else if (date.day == now.subtract(Duration(days: 1)).day)
      when = 'Hôm qua';
    else
      when = DateFormat.MMMd("vi").format(date);
    return when;
  }

  void captureImage(ImageSource captureMode) async {
    final observer = Provider.of<Observer>(this.context, listen: false);
    try {
      PickedFile? pickedImage = await (picker.getImage(source: captureMode));
      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
        setState(() {});
        if (imageFile!.lengthSync() / 1000000 >
            observer.maxFileSizeAllowedInMB) {
          setState(() {
            imageFile = null;
          });
        } else {
          imageFile = File(imageFile!.path);
          var url = await uploadFileWithProgressIndicator(false);
          onSendMessage(this.context, url, MessageType.image, uploadTimestamp);
        }
      }
    } catch (e) {}
  }

  showToastLock(observer, int type, BuildContext context) {
    if (!observer.ismediamessagingallowed && type == 1) {
      Fiberchat.toast(
        'Tin nhắn media bị khóa',
      );
    } else if (chatStatus == ChatStatus.blocked.index && type == 2) {
      Fiberchat.toast(
        'Mở khóa',
      );
    } else {
      if (type == 1 && observer.ismediamessagingallowed) {
        captureImage(ImageSource.gallery);
      } else if (type == 2 && chatStatus != ChatStatus.blocked.index) {
        hidekeyboard(context);
        shareMedia(context);
      }
    }
  }

  shareMedia(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (BuildContext context) {
          // return your layout
          return Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      RawMaterialButton(
                        disabledElevation: 0,
                        onPressed: () {
                          hidekeyboard(context);
                          Navigator.of(context).pop();
                          captureImage(ImageSource.camera);
                        },
                        elevation: .5,
                        fillColor: Colors.indigo,
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Máy ảnh",
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      RawMaterialButton(
                        disabledElevation: 0,
                        onPressed: () {
                          hidekeyboard(context);
                          Navigator.of(context).pop();
                          captureImage(ImageSource.gallery);
                        },
                        elevation: .5,
                        fillColor: Colors.pink[600],
                        child: Icon(
                          Icons.image_rounded,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Thư viện",
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    var _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    final observer = Provider.of<Observer>(context, listen: true);
    return KeyboardDismisser(
      child: Fiberchat.getNTPWrappedWidget(
        child: WillPopScope(
          onWillPop: isgeneratingThumbnail == true
              ? () async {
                  return Future.value(false);
                }
              : isemojiShowing == true
                  ? () {
                      setState(() {
                        isemojiShowing = false;
                      });
                      return Future.value(false);
                    }
                  : () async {
                      setLastSeen();
                      WidgetsBinding.instance!
                          .addPostFrameCallback((timeStamp) async {
                        var currentpeer = Provider.of<CurrentChatPeer>(
                            this.context,
                            listen: false);
                        currentpeer.setpeer(newpeerid: '');
                        if (lastSeen == peerNo)
                          await FirebaseFirestore.instance
                              .collection(DbPaths.collectionusers)
                              .doc(currentUserNo)
                              .update(
                            {Dbkeys.lastSeen: true},
                          );
                      });

                      return Future.value(true);
                    },
          child: ScopedModel<DataModel>(
              model: _cachedModel,
              child: ScopedModelDescendant<DataModel>(
                  builder: (context, child, _model) {
                _cachedModel = _model;
                updateLocalUserData(_model);
                return Scaffold(
                  appBar: PageAppBar(
                    title: widget.arguments.name,
                  ),
                  body: Column(
                    children: [
                      Expanded(
                          child: Stack(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // List of messages
                              buildMessages(context),
                              // Input content
                              isBlocked()
                                  ? Container()
                                  : BuildInputChat(
                                      context: context,
                                      isemojiShowing: isemojiShowing,
                                      refreshThisInput: refreshInput,
                                      keyboardVisible: _keyboardVisible,
                                      textSend: textSend,
                                      chatStatus: chatStatus,
                                      keyboardFocusNode: keyboardFocusNode,
                                      onSendText: () {
                                        if (textSend.text.isNotEmpty) {
                                          onSendMessage(
                                              context,
                                              textSend.text,
                                              MessageType.text,
                                              DateTime.now()
                                                  .millisecondsSinceEpoch);
                                        }
                                      },
                                      onSendImageCamera: () async {
                                        await showToastLock(
                                            observer, 2, context);
                                      },
                                      onSendFile: () async {
                                        await showToastLock(
                                            observer, 2, context);
                                      }),
                            ],
                          ),
                          BuildLoadingChat(isLoading)
                        ],
                      )),
                    ],
                  ),
                );
              })),
        ),
      ),
    );
  }
}
