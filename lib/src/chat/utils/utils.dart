//*************   © Copyrighted by Thinkcreative_Technologies. An Exclusive item of Envato market. Make sure you have purchased a Regular License OR Extended license for the Source Code from Envato to use this product. See the License Defination attached with source code. *********************

import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ntp/ntp.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:share/share.dart';

import '../config/Dbkeys.dart';
import '../config/Enum.dart';
import '../config/string_path.dart';
import '../models/data_model.dart';
import 'color.dart';
class Fiberchat {
  static String? getNickname(Map<dynamic,dynamic> user) =>
      user[Dbkeys.aliasName] ?? user[Dbkeys.nickname];

  static void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: fiberchatBlack.withOpacity(0.95),
        textColor: fiberchatWhite);
  }

  static void internetLookUp() async {
    try {
      await InternetAddress.lookup('google.com').catchError((e) {
        Fiberchat.toast('No internet connection ${e.toString()}');
      });
    } catch (err) {
      Fiberchat.toast('No internet connection. ${err.toString()}');
    }
  }

  static void invite(BuildContext context) {
    Share.share('$share_title $AppName, $share_link - ${Platform.isIOS ? AppIosLink : AppAndroiLink}');
  }

  static Widget avatar(Map<String, dynamic>? user,
      {File? image, double radius = 22.5}) {
    if (image == null) {
      if (user![Dbkeys.aliasAvatar] == null)
        return (user[Dbkeys.photoUrl] ?? '').isNotEmpty
            ? CircleAvatar(
                backgroundColor: Colors.grey[200],
                backgroundImage:
                    CachedNetworkImageProvider(user[Dbkeys.photoUrl]),
                radius: radius)
            : CircleAvatar(
                backgroundColor: fiberchatgreen,
                foregroundColor: Colors.white,
                child: Text(getInitials(Fiberchat.getNickname(user)!)),
                radius: radius,
              );
      return CircleAvatar(
        backgroundImage: Image.file(File(user[Dbkeys.aliasAvatar])).image,
        radius: radius,
      );
    }
    return CircleAvatar(
        backgroundImage: Image.file(image).image, radius: radius);
  }

  static Future<int> getNTPOffset() {
    return NTP.getNtpOffset();
  }

  static Widget getNTPWrappedWidget({ required Widget child}) {
    return FutureBuilder(
        future: NTP.getNtpOffset(),
        builder: (context, AsyncSnapshot<int> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            if (snapshot.data! > Duration(minutes: 1).inMilliseconds ||
                snapshot.data! < -Duration(minutes: 1).inMilliseconds)
              return Center(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        err_time,
                        style:
                            TextStyle(color: fiberchatWhite, fontSize: 18),
                      )));
          }
          return child;
        });
  }

  static void showRationale(rationale) async {
    Fiberchat.toast(rationale);
    await Future.delayed(Duration(seconds: 2));
    Fiberchat.toast(open_permissions);
  }

  static Future<bool> checkAndRequestPermission(Permission permission) {
    Completer<bool> completer = new Completer<bool>();
    permission.request().then((status) {
      if (status != PermissionStatus.granted) {
        permission.request().then((_status) {
          bool granted = _status == PermissionStatus.granted;
          completer.complete(granted);
        });
      } else
        completer.complete(true);
    });
    return completer.future;
  }

  static String getInitials(String name) {
    try {
      List<String> names = name
          .trim()
          .replaceAll(new RegExp(r'[\W]'), '')
          .toUpperCase()
          .split(' ');
      names.retainWhere((s) => s.trim().isNotEmpty);
      if (names.length >= 2)
        return names.elementAt(0)[0] + names.elementAt(1)[0];
      else if (names.elementAt(0).length >= 2)
        return names.elementAt(0).substring(0, 2);
      else
        return names.elementAt(0)[0];
    } catch (e) {
      return '?';
    }
  }

  static String getChatId(String? currentUserNo, String? peerNo) {
    if (currentUserNo.hashCode <= peerNo.hashCode)
      return '$currentUserNo-$peerNo';
    return '$peerNo-$currentUserNo';
  }

  static AuthenticationType getAuthenticationType(
      bool biometricEnabled, DataModel? model) {
    if (biometricEnabled && model?.currentUser != null) {
      return AuthenticationType
          .values[model!.currentUser![Dbkeys.authenticationType]];
    }
    return AuthenticationType.passcode;
  }

  static ChatStatus getChatStatus(int index) => ChatStatus.values[index];

  static String normalizePhone(String phone) =>
      phone.replaceAll(new RegExp(r"\s+\b|\b\s"), "");

  static String getHashedAnswer(String answer) {
    answer = answer.toLowerCase().replaceAll(new RegExp(r"[^a-z0-9]"), "");
    var bytes = utf8.encode(answer); // data being hashed
    Digest digest = sha1.convert(bytes);
    return digest.toString();
  }

  static String getHashedString(String str) {
    var bytes = utf8.encode(str); // data being hashed
    Digest digest = sha1.convert(bytes);
    return digest.toString();
  }
}