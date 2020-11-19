import 'package:flutter/material.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';

class Reminder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Reminder',style: startText,),),
    );
  }
}
