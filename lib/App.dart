
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivation_quotes/src/AppConfigurations/Routes.dart';
import 'package:motivation_quotes/src/AppConfigurations/Theme.dart';
import 'package:motivation_quotes/src/backend/adMobService.dart';
import 'package:motivation_quotes/src/backend/sqliteDB.dart';
import 'package:motivation_quotes/src/controller/Catergories/catergoryContoller.dart';
import 'package:motivation_quotes/src/controller/Notification/Notification_Manager.dart';
import 'package:motivation_quotes/src/controller/Notification/reminderController.dart';
import 'package:motivation_quotes/src/controller/Notification/reminderModel.dart';
import 'package:motivation_quotes/src/controller/collection/ProfileController.dart';
import 'package:motivation_quotes/src/frontend/SplashScreens/SplashScreen.dart';
import 'package:motivation_quotes/src/frontend/SplashScreens/start.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SqliteDB db = SqliteDB();
    return MultiProvider(
      providers: [
        Provider<NotificationManager>(
          create: (context) => NotificationManager.initNotificationManager(),
        ),
        Provider<SqliteDB>(create: (context) => SqliteDB()),
        Provider<CatergoryBloc>(create: (context) => CatergoryBloc()),
        Provider<ReminderBloc>(create: (context) => ReminderBloc()),
        Provider<ProfileBloc>(create: (context) => ProfileBloc()),
        Provider<AdMobServices>(create: (context)=> AdMobServices()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.cupertinoPageRoute,
          theme: theme(),
          home: Home(db: db)),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key key,
    @required this.db,
  }) : super(key: key);

  final SqliteDB db;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ReminderModel>(
        future: db.getReminder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold();
          }
          if (!snapshot.hasData) {
            return StartScreen();
          }
          return (snapshot.data.isUsingAppFirstTime == 1)
              ? SplashScreen()
              : StartScreen();
        });
  }
}
