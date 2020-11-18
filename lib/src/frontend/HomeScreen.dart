import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motivation_quotes/src/controller/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/controller/AppConfigurations/constants.dart';
import 'package:motivation_quotes/src/frontend/_widgets/BottomNavigationBar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, kShowNotification);
                  },
                  child: Text(
                    'Press Me!',
                    style: splashText(),
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
