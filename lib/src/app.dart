import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nanoshop/src/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:nanoshop/src/presentation/blocs/local_product_bloc/local_product_bloc.dart';
import 'package:nanoshop/src/presentation/blocs/post_bloc/post_bloc.dart';
import 'package:nanoshop/src/presentation/cubits/get_type_notification/get_type_notification_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/shopping_cart_cubit/shopping_cart_cubit.dart';
import 'package:provider/provider.dart';

import 'chat/provider/DownloadInfoProvider.dart';
import 'chat/provider/Observer.dart';
import 'chat/provider/currentchat_peer.dart';
import 'config/routers/app_router/app_router.dart';
import 'injector.dart';
import 'presentation/cubits/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'presentation/ui/home/sc_home.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Observer()),
        ChangeNotifierProvider(create: (_) => CurrentChatPeer()),
        ChangeNotifierProvider(create: (_) => DownloadInfoprovider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => injector<AuthenticationBloc>()
              ..add(
               const AuthenticationCheckLocalRequested(),
              ),
          ),
          BlocProvider<GetTypeNotificationCubit>(
            create: (context) => injector<GetTypeNotificationCubit>(),
          ),
          BlocProvider<BottomNavCubit>(
            create: (context) => injector<BottomNavCubit>(),
          ),
          BlocProvider<ShoppingCartCubit>(
            create: (context) => injector<ShoppingCartCubit>(),
          ),
          BlocProvider<LocalProductBloc>(
            create: (context) => injector<LocalProductBloc>()
              ..add(
                GetListFavouriteProductEvent(),
              ),
          ),
          BlocProvider(
            create: (BuildContext context) {
              return injector<PostBloc>()
                ..add(
                 const GetListPost(),
                );
            },
          ),
        ],
        child: MaterialApp(
          onGenerateRoute: AppRouters.onGenerateRoutes,
          home: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {},
            child: const ScHome(),
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('vi'),
          ],
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
        ),
      ),
    );
  }
}
