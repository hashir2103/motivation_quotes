// Splash Screen
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motivation_quotes/src/AppConfigurations/size.dart';

//splash screen texxt
TextStyle splashText() {
  return GoogleFonts.anton(
      textStyle: TextStyle(
          color: Colors.white,
          fontSize:
              getProportionateScreenWidth(SizeConfig.screenWidth * 0.17)));
}

//start screen
TextStyle get startText {
  return GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 30),
      color: Colors.black,
      decoration: TextDecoration.none);
}

TextStyle get startText2 {
  return GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 22),
      color: Colors.black,
      fontWeight: FontWeight.w700);
}

TextStyle get startText2small {
  return GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 18),
      color: Colors.black,
      fontWeight: FontWeight.w700);
}

//Bottom Navigation Text
TextStyle navText() {
  return GoogleFonts.roboto(
      textStyle: TextStyle(
    color: Color(0xFFFFFFFF),
  ));
}

// Quotes text
TextStyle get quoteText {
  return GoogleFonts.sourceCodePro(
      textStyle: TextStyle(fontSize: 24),
      color: Colors.white,
      // fontWeight: FontWeight.w700
      );
}
TextStyle get authorText {
  return GoogleFonts.sourceCodePro(
      textStyle: TextStyle(fontSize: 20),
      color: Colors.white,
      fontWeight: FontWeight.w700);
}

//AppBar text
TextStyle get appBarTitle {
  return GoogleFonts.roboto(
      textStyle: TextStyle(fontSize: 25),
      color: Colors.white,
      );
}

// Category label
TextStyle get catergoryLabel {
  return GoogleFonts.inconsolata(
      textStyle: TextStyle(fontSize: 26),
      color: Colors.white,
      fontStyle: FontStyle.italic,
      );
}