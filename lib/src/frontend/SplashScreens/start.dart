import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motivation_quotes/src/controller/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/controller/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/controller/AppConfigurations/size.dart';
import 'package:motivation_quotes/src/frontend/SplashScreens/start3.dart';
import 'package:motivation_quotes/src/frontend/_widgets/startButton.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
