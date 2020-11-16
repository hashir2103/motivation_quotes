import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motivation_quotes/src/controller/AppConfigurations/Routes.dart';
import 'package:motivation_quotes/src/controller/AppConfigurations/Theme.dart';
import 'package:motivation_quotes/src/frontend/SplashScreens/start.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.cupertinoPageRoute,
        theme: theme(),
        home: StartScreen());
  }
}
