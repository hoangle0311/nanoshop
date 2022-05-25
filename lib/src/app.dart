import 'package:flutter/material.dart';

import 'config/environment/app_environment.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(Environment.domain),
            ),
          );
        },
      ),
    );
  }
}
