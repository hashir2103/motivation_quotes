import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/AppConfigurations/size.dart';

abstract class Buttons {
  static Widget startButton(String text, Function onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          // padding: EdgeInsets.symmetric(vertical: 10),
          borderRadius: BorderRadius.circular(20),
          color: Color(0xFFe9f0f6).withOpacity(0.7),
        ),
        width: SizeConfig.screenWidth * 0.8,
        child: Center(
          child: Text(
            text,
            style: startText,
          ),
        ),
      ),
    );
  }
}
