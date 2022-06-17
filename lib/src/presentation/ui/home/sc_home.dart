import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/core/data/nav_data/nav_data_dev.dart';
import 'package:nanoshop/src/presentation/cubits/bottom_nav_cubit/bottom_nav_cubit.dart';

import '../../../core/params/token_param.dart';
import '../../../injector.dart';
import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/blocs.dart';
import '../../blocs/flash_sale_bloc/flash_sale_bloc.dart';
import '../../blocs/post_bloc/post_bloc.dart';
import '../../bottom_home_nav_bar.dart';
import '../../pages/pages.dart';

class ScHome extends StatelessWidget {
  const ScHome({Key? key}) : super(key: key);

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
                          return const ShoppingCartPage();
                        case 3:
                          return AccountPage();
                        case 4:
                          return AccountPage();
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
