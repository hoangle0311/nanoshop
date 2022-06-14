import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:nanoshop/src/presentation/blocs/blocs.dart';
import 'package:nanoshop/src/presentation/blocs/local_product_bloc/local_product_bloc.dart';
import 'package:nanoshop/src/presentation/cubits/shopping_cart_cubit/shopping_cart_cubit.dart';

import 'config/routers/app_router/app_router.dart';
import 'core/params/token_param.dart';
import 'injector.dart';
import 'presentation/blocs/flash_sale_bloc/flash_sale_bloc.dart';
import 'presentation/cubits/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'presentation/ui/home/sc_home.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<GetTokenBloc>(
        //   create: (context) => injector<GetTokenBloc>()
        //     ..add(
        //       GetToken(
        //         injector<TokenParam>().string,
        //         injector<TokenParam>().token,
        //       ),
        //     ),
        // ),
        BlocProvider<AuthenticationBloc>(
          create: (context) =>
          injector<AuthenticationBloc>()
            ..add(
              AuthenticationCheckLocalRequested(
                tokenParam: injector<TokenParam>(),
              ),
            ),
        ),
        BlocProvider<BottomNavCubit>(
          create: (context) => injector<BottomNavCubit>(),
        ),
        BlocProvider<ShoppingCartCubit>(
          create: (context) => injector<ShoppingCartCubit>(),
        ),
        BlocProvider<LocalProductBloc>(
          create: (context) =>
          injector<LocalProductBloc>()
            ..add(
              GetListFavouriteProductEvent(),
            ),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: AppRouters.onGenerateRoutes,
        home: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            print(state);
          },
          child: BlocBuilder<GetTokenBloc, GetTokenState>(
            builder: (BuildContext context, GetTokenState state) {
              return const ScHome();
            },
          ),
        ),
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
      ),
    );
  }
}
