import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/config/routers/app_router/app_router.dart';

import 'package:nanoshop/src/core/data/nav_data/nav_data_dev.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/blocs/authentication_bloc/authentication_bloc.dart';

import '../config/styles/app_color.dart';
import '../config/styles/app_text_style.dart';
import '../core/data/nav_data/nav_data_prod.dart';
import '../data/models/user/user_login_response_model.dart';
import '../domain/entities/user_login/user_login.dart';
import 'cubits/bottom_nav_cubit/bottom_nav_cubit.dart';

import 'dart:ui' as ui;

// class BottomHomeNavBar extends StatelessWidget {
//   const BottomHomeNavBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BottomNavCubit, BottomNavState>(
//       builder: (context, state) {
//         return BottomNavigationBar(
//           selectedItemColor: Colors.red,
//           unselectedItemColor: Colors.black,
//           currentIndex: state.index,
//           onTap: (index) {
// var authBloc = context.read<AuthenticationBloc>();
// var authState = authBloc.state;

// if (navDataItems[index].needUserAccess &&
//     authState.user == User.empty) {
//   Navigator.of(context).pushNamed(AppRouterEndPoint.LOGIN).then(
//     (value) {
//       if (value != null && value == true) {
//         injector.get<BottomNavCubit>().onTapBottomNav(index);
//       }
//     },
//   );

//   return;
// }
// injector.get<BottomNavCubit>().onTapBottomNav(index);
//           },
//           items: List.generate(
//             navDataItems.length,
//             (index) {
//               var navItem = navDataItems[index];

//               return BottomNavigationBarItem(
//                 icon: navItem.icon,
//                 label: navItem.label,
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

class BottomHomeNavBar extends StatelessWidget {
  const BottomHomeNavBar({
    Key? key,
  }) : super(key: key);

  Widget buildItemNav({
    model,
    required int index,
    required int currentIndex,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () {
        var authBloc = context.read<AuthenticationBloc>();
        var authState = authBloc.state;

        if (dummyBottomNav[index].needUserAccess &&
            authState.user == UserLogin.empty) {
          Navigator.of(context).pushNamed(AppRouterEndPoint.LOGIN).then(
            (value) {
              if (value != null && value == true) {
                injector.get<BottomNavCubit>().onTapBottomNav(index);
              }
            },
          );

          return;
        }
        injector.get<BottomNavCubit>().onTapBottomNav(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              model.url,
              color:
                  currentIndex != index ? Colors.white : AppColors.primaryColor,
            ),
            Text(
              model.name,
              style: TextStyleApp.textStyle7.copyWith(
                color: currentIndex != index
                    ? Colors.white
                    : AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        return Container(
          height: 100,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: 80,
                  color: Colors.transparent,
                  child: CustomPaint(
                    size: Size(size.width, 80),
                    painter: BottomPainter(),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                left: 0,
                right: 0,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColors.primaryColor,
                                  AppColors.yellow,
                                ],
                              ).createShader(bounds);
                            },
                            child: Text(
                              'T',
                              style: TextStyleApp.textStyle3.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColors.primaryColor,
                              AppColors.yellow,
                            ],
                          ).createShader(bounds);
                        },
                        child: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: size.width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildItemNav(
                        model: dummyBottomNav[0],
                        index: 0,
                        context: context,
                        currentIndex: state.index,
                      ),
                      buildItemNav(
                        model: dummyBottomNav[1],
                        index: 1,
                        context: context,
                        currentIndex: state.index,
                      ),
                      SizedBox(
                        width: size.width * 0.2,
                      ),
                      buildItemNav(
                        model: dummyBottomNav[2],
                        index: 2,
                        currentIndex: state.index,
                        context: context,
                      ),
                      buildItemNav(
                        model: dummyBottomNav[3],
                        index: 3,
                        context: context,
                        currentIndex: state.index,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BottomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(0, 80),
        [
          HexColor("#030102"),
          HexColor("#3A3A3A"),
        ],
      )
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.quadraticBezierTo(size.width * 0.2, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.4, 0, size.width * 0.4, 20);
    path.arcToPoint(
      Offset(
        size.width * 0.6,
        10,
      ),
      radius: Radius.circular(5),
      clockwise: false,
    );
    path.quadraticBezierTo(size.width * 0.6, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.8, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
