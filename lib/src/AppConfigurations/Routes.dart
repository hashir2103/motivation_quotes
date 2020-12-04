import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motivation_quotes/src/AppConfigurations/constants.dart';
import 'package:motivation_quotes/src/frontend/HomeScreens/HomeScreen.dart';
import 'package:motivation_quotes/src/frontend/ProfileScreens/favourite.dart';
import 'package:motivation_quotes/src/frontend/ProfileScreens/myQuote.dart';
import 'package:motivation_quotes/src/frontend/ProfileScreens/profile.dart';
import 'package:motivation_quotes/src/frontend/ReminderScreens/reminder.dart';
import 'package:motivation_quotes/src/frontend/SplashScreens/SplashScreen.dart';
import 'package:motivation_quotes/src/frontend/SplashScreens/splashscreen1.dart';
import 'package:motivation_quotes/src/frontend/ThemeScreens/appTheme.dart';
import 'package:motivation_quotes/src/frontend/catergoriesScreens/catergory.dart';

abstract class Routes {

  static CupertinoPageRoute cupertinoPageRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (context) => SplashScreen1());

      case kHomeScreen:
        return CupertinoPageRoute(builder: (context) => HomeScreen());

      case ksplashScreen2:
        return CupertinoPageRoute(builder: (context) => SplashScreen());

      case kCatergoryScreen:
        return CupertinoPageRoute(builder: (context) => Catergory());
      
      case kProfileScreen:
        return CupertinoPageRoute(builder: (context) => Profile());
      
      case kReminderScreen:
        return CupertinoPageRoute(builder: (context) => Reminder());
      
      case kThemeScreen:
        return CupertinoPageRoute(builder: (context) => AppThemes());
      
      case kMyFav:
        return CupertinoPageRoute(builder: (context) => MyFav());
      
      case kOwnQuote:
        return CupertinoPageRoute(builder: (context) => MyQuote());

      
      

      default:
        
        
        
        
        
        
        
        return CupertinoPageRoute(builder: (context) => HomeScreen());
    }
  }
}
