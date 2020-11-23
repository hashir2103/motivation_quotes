import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/AppConfigurations/size.dart';
import 'package:motivation_quotes/src/backend/sqliteDB.dart';
import 'package:motivation_quotes/src/controller/Quotes/quotesModel.dart';
import 'package:motivation_quotes/src/frontend/SplashScreens/start3.dart';
import 'package:motivation_quotes/src/frontend/_widgets/startButton.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  
  @override
  void initState() {
    var db = Provider.of<SqliteDB>(context, listen: false);
    db.init();
    // db.deleteAllQuotes();
    // db.deleteDB();
    super.initState();
  }

  addQuoteToDb(db) {
    for (var quote in quotes) {
      db.addQuote(quote);
    }
    print('Quote added!..');
  }

  

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<SqliteDB>(context);
    addQuoteToDb(db);
    SizeConfig.init(context);
    return Container(
      decoration: BoxDecoration(gradient: kStartGradientColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                  backgroundColor: Color(0xFFe9f0f6).withOpacity(0.7),
                  radius: 55,
                  child: Icon(
                    FontAwesomeIcons.quoteRight,
                    color: Color(0xFF444444),
                    size: 60,
                  )),
              SizedBox(
                height: 70,
              )
            ],
          )),
          Expanded(
              child: Column(
            children: [
              Text(
                'self care.',
                style: startText,
                textAlign: TextAlign.center,
              ),
              Text(
                'self love.',
                style: startText,
              ),
              Text(
                'self growth.',
                style: startText,
              ),
            ],
          )),
          Buttons.startButton(
            'Get Started',
            () {
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => StartScreen3()));
            },
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
