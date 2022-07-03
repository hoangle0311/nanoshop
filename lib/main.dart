import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/presentation/blocs/blocs.dart';

import 'src/app.dart';
import 'src/config/environment/app_environment.dart';
import 'src/injector.dart';

Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {}

Future<Uint8List> getByteArrayFromUrl(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  return response.bodyBytes;
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  AndroidInitializationSettings initializationSettingsAndroid =
      new AndroidInitializationSettings('@mipmap/ic_launcher');
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {}
  });

  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await dotenv.load(
    fileName: Environment.getEnvironmentFile,
  );

  await initializeDependencies();

  injector<GetTokenBloc>().add(
    GetToken(
      injector<TokenParam>().string,
      injector<TokenParam>().token,
    ),
  );

  await Future.delayed(const Duration(milliseconds: 200));

  runApp(
    BlocProvider(
      create: (context) => injector<GetTokenBloc>(),
      child: const App(),
    ),
  );
}
