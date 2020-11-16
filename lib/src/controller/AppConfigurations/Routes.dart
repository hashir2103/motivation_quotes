
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motivation_quotes/src/controller/AppConfigurations/constants.dart';
import 'package:motivation_quotes/src/frontend/HomeScreen.dart';
import 'package:motivation_quotes/src/frontend/SplashScreens/SplashScreen.dart';
import 'package:motivation_quotes/src/frontend/SplashScreens/splashscreen1.dart';

abstract class Routes {
  static MaterialPageRoute materialPageRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => SplashScreen1());
      
      default:
        // var routeArray = settings.name.split('/');
        // if (settings.name.contains('/editproduct/')) {
        //   print(routeArray[2]);
        //   return MaterialPageRoute(
        //       builder: (context) => EditProduct(
        //             productId: routeArray[2],
        //           ));
        // } 
        return MaterialPageRoute(builder: (context) => SplashScreen1());
    }
  }

  static CupertinoPageRoute cupertinoPageRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (context) => SplashScreen1());
      
      case kHomeScreen:
        return CupertinoPageRoute(builder: (context) => HomeScreen());
      
      case ksplashScreen2:
        return CupertinoPageRoute(builder: (context) => SplashScreen());

      
      default:
        // var routeArray = settings.name.split('/');
        // if (settings.name.contains('/editproduct/')) {
        //   return CupertinoPageRoute(
        //       builder: (context) => EditProduct(
        //             productId: routeArray[2],
        //           ));
        // } 
        return CupertinoPageRoute(builder: (context) => SplashScreen1());
    }
  }
}
