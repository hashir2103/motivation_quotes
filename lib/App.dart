import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motivation_quotes/src/controller/AppConfigurations/Routes.dart';
import 'package:motivation_quotes/src/controller/AppConfigurations/Theme.dart';
import 'package:motivation_quotes/src/controller/NotificationController/Notification_Manager.dart';
import 'package:motivation_quotes/src/frontend/SplashScreens/start.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer timer;
  @override
  void initState() {
    super.initState();
    // timer =
        // Timer.periodic(Duration(seconds: 15), (timer) => print('===hello==='));
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NotificationManager>(
          create: (context) => NotificationManager.initNotificationManager(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.cupertinoPageRoute,
          theme: theme(),
          home: StartScreen()),
    );
  }
}
