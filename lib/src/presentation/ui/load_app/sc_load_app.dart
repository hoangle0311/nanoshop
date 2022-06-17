import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routers/app_router/app_router.dart';
import '../../../core/assets/image_path.dart';
import '../../blocs/blocs.dart';

class ScLoadApp extends StatelessWidget {
  const ScLoadApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetTokenBloc, GetTokenState>(
      listener: (context, state){
        if(state is GetTokenDone){
          Navigator.of(context).pushReplacementNamed(AppRouterEndPoint.HOME);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                ImagePath.backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Image.asset(
                ImagePath.appIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
