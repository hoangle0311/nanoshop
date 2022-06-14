import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/presentation/blocs/blocs.dart';

import 'src/app.dart';
import 'src/config/environment/app_environment.dart';
import 'src/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(
    fileName: Environment.getEnvironmentFile,
  );

  await initializeDependencies();

  runApp(
    BlocProvider(
      create: (context) => injector<GetTokenBloc>()
        ..add(
          GetToken(
            injector<TokenParam>().string,
            injector<TokenParam>().token,
          ),
        ),
      child: const App(),
    ),
  );
}
