import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../main.dart';
import '../models/data_model.dart';
import 'firebase_account.dart';

class FirebaseSendNotifi {
  static sendNotifi({
    required String title,
    required String body,
    Map<String, dynamic>? data,
    required id_send,
  }) async {
    var url = "https://fcm.googleapis.com/fcm/send";
    var tokenSendTo = await FireBaseAccount.getData(id_send);
    Map<String, String> headers = new Map();
    Map<String, dynamic> body_req = new Map();
    Map<String, dynamic> body_data = new Map();
    String key =
        "AAAAbXHIOuI:APA91bHob-SdlK9QJIm4D98inKZ_-Ndo_YjFXfggSyvqvKS3ZwfAqkAn0n01ya3q7XRgMCVvjYeVRZQDLebLvHuW169AjICE53xH4TCicp2MrirHEcp4xQ-eCGG5jPt063lfITKD9Z_Z";

    headers = {"Authorization": "key=$key", "Content-Type": "application/json"};
    body_req['registration_ids'] = tokenSendTo.data()["notificationTokens"];
    body_req['priority'] = "high";
    body_req['notification'] = {
      "title": title,
      "body": body,
    };
    if (data != null) {
      data.forEach((key, value) {
        if (key != "from") {
          body_data[key] = value;
        } else {
          body_data["from_send"] = value;
        }
      });
      body_data['title'] = title;
      body_data['body'] = body;
      body_data['click_action'] = "FLUTTER_NOTIFICATION_CLICK";
      body_data['chat'] = "1";
      body_data['pay_load'] = "chat";
      body_req['data'] = body_data;
    } else {
      body_req['data'] = {
        "title": title,
        "body": body,
      };
    }

    var jsonData;
    try {
      var response = await http
          .post(Uri.parse(url), headers: headers, body: json.encode(body_req))
          .timeout(
        Duration(seconds: 10),
        onTimeout: () {
          return jsonData;
        },
      );
      jsonData = await json.decode(response.body);
    } catch (e) {
      jsonData = null;
    }
  }

  static showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'full screen channel id', 'full screen channel name',
            channelDescription: 'full screen channel description',
            priority: Priority.high,
            importance: Importance.high,
            ticker: 'ticker',
            fullScreenIntent: false);
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(
      presentAlert: true,
      // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentBadge: true,
      // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentSound:
          true, // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.data['title'],
      message.data['body'],
      platformChannelSpecifics,
      payload: json.encode(message.data),
    );
  }

  static showImage(RemoteMessage message) async {
    final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
        await getByteArrayFromUrl(message.data['image_url']));
    final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
        await getByteArrayFromUrl(message.data['image_url']));

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(bigPicture,
            largeIcon: largeIcon,
            contentTitle: message.data['title'],
            htmlFormatContentTitle: true,
            summaryText: message.data['body'],
            htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'big text channel id', 'big text channel name',
            channelDescription: 'big text channel description',
            styleInformation: bigPictureStyleInformation);
    IOSNotificationDetails(
      presentAlert: true,
      // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentBadge: true,
      // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentSound:
          true, // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, message.data['title'],
        message.data['body'], platformChannelSpecifics,
        payload: json.encode(message.data));
  }

  static nextPageNotifi(BuildContext context, res) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DataModel model = DataModel(res['from_send']);
    if (res['to'] != null) {
      flutterLocalNotificationsPlugin.cancelAll();
    }
  }

  static init(BuildContext context) async {
    AndroidInitializationSettings initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        var res = await json.decode(payload);
        if (res['chat'] == "1") {
          nextPageNotifi(context, res);
        }
      }
    });
  }
}
