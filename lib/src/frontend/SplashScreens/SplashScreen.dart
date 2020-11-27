import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/AppConfigurations/constants.dart';
import 'package:motivation_quotes/src/AppConfigurations/size.dart';
import 'package:motivation_quotes/src/backend/sqliteDB.dart';
import 'package:motivation_quotes/src/controller/Catergories/catergoryContoller.dart';
import 'package:motivation_quotes/src/controller/Catergories/catergoryModel.dart';
import 'package:motivation_quotes/src/controller/Notification/reminderController.dart';
import 'package:motivation_quotes/src/frontend/HomeScreens/HomeScreen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getMyCatAndUpdateStream(SqliteDB db, CatergoryBloc catBloc) async {
    List<CatergoryModel> myCats = [];
    myCats = await db.getMyCat();
    for (var cat in myCats) {
      if (cat.catergoryName == kPast && cat.showCatergory == 1) {
        catBloc.changePast(true);
      }
      if (cat.catergoryName == kFitness && cat.showCatergory == 1) {
        catBloc.changeWorkout(true);
      }
      if (cat.catergoryName == kProductivity && cat.showCatergory == 1) {
        catBloc.changeProductivity(true);
      }
      if (cat.catergoryName == kLove && cat.showCatergory == 1) {
        catBloc.changeLove(true);
      }
      if (cat.catergoryName == kSaying && cat.showCatergory == 1) {
        catBloc.changeSaying(true);
      }
      if (cat.catergoryName == kMonday && cat.showCatergory == 1) {
        catBloc.changeMonday(true);
      }
      if (cat.catergoryName == kLife && cat.showCatergory == 1) {
        catBloc.changeLife(true);
      }
      if (cat.catergoryName == kInspiration && cat.showCatergory == 1) {
        catBloc.changeInspiration(true);
      }
      if (cat.catergoryName == kHardtimes && cat.showCatergory == 1) {
        catBloc.changeHardtimes(true);
      }
      if (cat.catergoryName == kFuture && cat.showCatergory == 1) {
        catBloc.changeFuture(true);
      }
      if (cat.catergoryName == kBirthday && cat.showCatergory == 1) {
        catBloc.changeBirthday(true);
      }
      if (cat.catergoryName == kNight && cat.showCatergory == 1) {
        catBloc.changeNight(true);
      }
      if (cat.catergoryName == kTravel && cat.showCatergory == 1) {
        catBloc.changeTravel(true);
      }
      if (cat.catergoryName == kSport && cat.showCatergory == 1) {
        catBloc.changeSport(true);
      }
      if (cat.catergoryName == kSelfesteem && cat.showCatergory == 1) {
        catBloc.changeSelfEsteem(true);
      }
      if (cat.catergoryName == kPassion && cat.showCatergory == 1) {
        catBloc.changePassion(true);
      }
    }
  }

  getReminderAndUpdateStream(SqliteDB db, ReminderBloc remBloc) async {
    var rem = await db.getReminder();
    remBloc.changeCount(rem.reminderCount);
    remBloc.changeStartTime(rem.startTime);
    remBloc.changeEndTime(rem.endTime);
    remBloc.changeTypeOfQuote(rem.typeOfquote);
  }

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<SqliteDB>(context);
    var catBloc = Provider.of<CatergoryBloc>(context);
    var remBloc = Provider.of<ReminderBloc>(context);
    getMyCatAndUpdateStream(db, catBloc);
    getReminderAndUpdateStream(db, remBloc);
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: AnimatedSplashScreen(
                backgroundColor: kPrimaryColor,
                animationDuration: Duration(milliseconds: 2500),
                duration: 2500,
                splashTransition: SplashTransition.rotationTransition,
                curve: Curves.easeInOutBack,
                nextScreen: Text1(),
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
    // for (var i in themesList) {
    //   precacheImage(AssetImage('assets/themes/$i'), context);
    // }
    return AnimatedSplashScreen(
        backgroundColor: kPrimaryColor,
        animationDuration: Duration(milliseconds: 2500),
        duration: 2500,
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
        animationDuration: Duration(milliseconds: 2500),
        duration: 2500,
        splashTransition: SplashTransition.slideTransition,
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
        animationDuration: Duration(milliseconds: 2500),
        duration: 2500,
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
