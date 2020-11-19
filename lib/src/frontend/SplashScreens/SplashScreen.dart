import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/AppConfigurations/size.dart';
import 'package:motivation_quotes/src/frontend/HomeScreens/HomeScreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: AnimatedSplashScreen(
                backgroundColor: kPrimaryColor,
                animationDuration: Duration(milliseconds: 3500),
                duration: 3520,
                splashTransition: SplashTransition.rotationTransition,
                curve: Curves.easeInOutBack,
                nextScreen: SplashScreen(),
                splash: Icon(
                  Icons.format_quote,
                  color: kIconColor,
                  size: getProportionateScreenWidth(120),
                )),
          ),
          Expanded(flex: 1, child: Text1()),
          Expanded(flex: 1, child: Text2()),
          Expanded(flex: 1, child: Text3()),
          Expanded(flex: 2, child: Container()),
        ],
      ),
    );
  }
}

class Text1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        backgroundColor: kPrimaryColor,
        animationDuration: Duration(milliseconds: 3500),
        duration: 3520,
        splashTransition: SplashTransition.slideTransition,
        // backgroundColor: kcolor3,
        curve: Curves.easeInOutBack,
        nextScreen: Text2(),
        splash: Text(
          "DREAM IT!",
          style: splashText(),
        ));
  }
}

class Text2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        animationDuration: Duration(milliseconds: 3500),
        duration: 3520,
        splashTransition: SplashTransition.slideTransitionReverse,
        backgroundColor: kPrimaryColor,
        curve: Curves.easeInOutBack,
        nextScreen: Text3(),
        splash: Text(
          "WISH IT!",
          style: splashText(),
        ));
  }
}

class Text3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        backgroundColor: kPrimaryColor,
        animationDuration: Duration(milliseconds: 3500),
        duration: 3520,
        splashTransition: SplashTransition.slideTransition,
        // backgroundColor: kcolor2,
        curve: Curves.easeInOutBack,
        nextScreen: HomeScreen(),
        splash: Text(
          "Do IT!",
          style: splashText(),
        ));
  }
}
