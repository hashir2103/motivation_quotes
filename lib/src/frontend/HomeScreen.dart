import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motivation_quotes/src/controller/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/controller/AppConfigurations/constants.dart';
import 'package:motivation_quotes/src/frontend/_widgets/BottomNavigationBar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kPrimaryColor,
      body: Container(
        child: Center(
          child: FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, ksplashScreen2);
              },
              child: Text('Press Me!',style:splashText(),)),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
