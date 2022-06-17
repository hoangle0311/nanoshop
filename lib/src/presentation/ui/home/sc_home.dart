import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/core/data/nav_data/nav_data_dev.dart';
import 'package:nanoshop/src/presentation/cubits/bottom_nav_cubit/bottom_nav_cubit.dart';

import '../../../../main.dart';
import '../../../chat/firebase/firebase_send_notifi.dart';
import '../../../core/params/token_param.dart';
import '../../../injector.dart';
import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/blocs.dart';
import '../../blocs/flash_sale_bloc/flash_sale_bloc.dart';
import '../../blocs/post_bloc/post_bloc.dart';
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
    // TODO: implement initState
    super.initState();
  }

  void listenToNotification() async {
    // final chatProvider = Provider.of<ChatProvider>(context, listen: false);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // chatProvider.setMessageCount();

      if (message.data["pay_load"] == "chat") {
        flutterLocalNotificationsPlugin..cancelAll();
      } else {
        if (message.data['image_url'] != null) {
          FirebaseSendNotifi.showImage(message);
        } else {
          FirebaseSendNotifi.showNotification(message);
        }
      }
      flutterLocalNotificationsPlugin.cancelAll();
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // chatProvider.setMessageCount();

      if (message.data["pay_load"] == "chat") {
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
    return BlocBuilder<GetTokenBloc, GetTokenState>(
      builder: (context, state) {
        if (state is GetTokenDone) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<FlashSaleBloc>(
                create: (context) => injector<FlashSaleBloc>()
                  ..add(
                    GetFlashSale(
                      tokenParam: injector<TokenParam>(),
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

        return Container();
      },
    );
  }
}
