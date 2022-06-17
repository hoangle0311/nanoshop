import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nanoshop/src/config/environment/environment.dart';
import 'package:nanoshop/src/domain/entities/user_login/user_login.dart';

import '../config/Dbkeys.dart';
import '../config/Dbpaths.dart';

class FireBaseAccount{
  static updateUser(Map<String, Object?> dataUpdate, UserLogin userLogin) async {
     await FirebaseFirestore.instance
         .collection(DbPaths.collectionusers)
         .doc(userLogin.userId!)
         .set(dataUpdate,SetOptions(merge: true));
  }

  static getData(user_id) async {
    return await FirebaseFirestore.instance
        .collection(DbPaths.collectionusers)
        .doc(user_id)
        .get();
  }

  static getAvataUser(user_id) async {
    String url = Environment.domain;
    var res =  await FirebaseFirestore.instance
        .collection(DbPaths.collectionusers)
        .doc(user_id)
        .get();
    if(res.data() != null ){
       url = "${res.data()![Dbkeys.avatar].toString()}";
    }


    // url = "https://tophinhanh.com/wp-content/uploads/2021/12/hinh-avatar-cute-nhat-1-564x375.jpg";

    return url ;
  }


  static createUser({
    String? id,
    String? name,
    String? avatar,
  }) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection(DbPaths.collectionusers)
        .where(Dbkeys.id, isEqualTo: id).get();

    final List documents = result.docs;

    if (documents.isEmpty) {
      await FirebaseFirestore.instance
          .collection(DbPaths.collectionusers)
          .doc(id)
          .set({
        Dbkeys.nickname: name ?? '',
        Dbkeys.id: id,
        Dbkeys.avatar: avatar ?? "",
        Dbkeys.lastLogin: DateTime.now().millisecondsSinceEpoch,
        Dbkeys.joinedOn: DateTime.now().millisecondsSinceEpoch,
      }, SetOptions(merge: true));
    } else {
      await FirebaseFirestore.instance
          .collection(DbPaths.collectionusers)
          .doc(id)
          .update(
        !documents[0].data().containsKey(Dbkeys.deviceDetails)
            ? {
          Dbkeys.lastLogin: DateTime.now().millisecondsSinceEpoch,
          Dbkeys.joinedOn:
              documents[0].data()[Dbkeys.lastSeen] != true
                  ? documents[0].data()[Dbkeys.lastSeen]
                  : DateTime.now().millisecondsSinceEpoch,
          Dbkeys.nickname: name.toString().trim(),
          Dbkeys.avatar: avatar ?? "",
        } : {
          Dbkeys.nickname: name.toString().trim(),
          Dbkeys.lastLogin: DateTime.now().millisecondsSinceEpoch,
          Dbkeys.avatar: avatar ?? "",
        },
      );
    }
  }

  static addToken(id) async {
    String fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
    await FirebaseFirestore.instance
        .collection(DbPaths.collectionusers)
        .doc(id)
        .set({
      Dbkeys.notificationTokens: FieldValue.arrayUnion([fcmToken]),
    }, SetOptions(merge: true));
  }

  static removeToken(id) async {
    String fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
    await FirebaseFirestore.instance
        .collection(DbPaths.collectionusers)
        .doc(id)
        .set({
      Dbkeys.notificationTokens: FieldValue.arrayRemove([fcmToken]),
    }, SetOptions(merge: true));
  }
}