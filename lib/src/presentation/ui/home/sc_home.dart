import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/core/data/nav_data/nav_data_dev.dart';
import 'package:nanoshop/src/presentation/cubits/bottom_nav_cubit/bottom_nav_cubit.dart';

import '../../../../main.dart';
import '../../../chat/firebase/firebase_send_notifi.dart';
import '../../../injector.dart';
import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/flash_sale_bloc/flash_sale_bloc.dart';
import '../../bottom_home_nav_bar.dart';
import '../../pages/notification_page/notification_page.dart';
import '../../pages/pages.dart';

class ScHome extends StatefulWidget {
  const ScHome({Key? key}) : super(key: key);

  @override
  State<ScHome> createState() => _ScHomeState();
}

class _ScHomeState extends State<ScHome> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((value) => print(value));
    listenToNotification();
  }

  void listenToNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data["pay_load"] == "chat") {
        context.read<AuthenticationBloc>().add(
              AddMessageUserLocal(),
            );
        FirebaseSendNotifi.showNotification(message);

        FirebaseSendNotifi.buildShowNotifi(
          message,
          context,
        );
      } else {
        if (message.data['image_url'] != null) {
          FirebaseSendNotifi.showImage(message);
        } else {
          FirebaseSendNotifi.showNotification(message);
          FirebaseSendNotifi.buildShowNotifi(
            message,
            context,
          );
        }
      }
      flutterLocalNotificationsPlugin.cancelAll();
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // chatProvider.setMessageCount();

      if (message.data["pay_load"] == "chat") {
        FirebaseSendNotifi.buildShowNotifi(
          message,
          context,
        );
        FirebaseSendNotifi.nextPageNotifi(context, message.data);
      } else {}
      flutterLocalNotificationsPlugin.cancelAll();
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        if (message.data["pay_load"] == "chat") {
          FirebaseSendNotifi.nextPageNotifi(context, message.data);
        } else {}
      }
      flutterLocalNotificationsPlugin.cancelAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FlashSaleBloc>(
          create: (context) => injector<FlashSaleBloc>()
            ..add(
              GetFlashSale(
              ),
            ),
        ),
      ],
      child: Scaffold(
        extendBody: true,
        body: BlocBuilder<BottomNavCubit, BottomNavState>(
          builder: (context, state) => IndexedStack(
            index: state.index,
            children: List.generate(
              navDataItems.length,
                  (index) {
                switch (index) {
                  case 0:
                    return const HomePage();
                  case 1:
                    return const PostPage();
                  case 2:
                    return const NotificationPage();
                  case 3:
                    return const AccountPage();
                  default:
                    return HomePage();
                }
              },
            ),
          ),
        ),
        bottomNavigationBar: const BottomHomeNavBar(),
      ),
    );
  }
}
