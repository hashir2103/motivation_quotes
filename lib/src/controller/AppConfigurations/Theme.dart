
import 'package:flutter/material.dart';

import 'Colors.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: kPrimaryColor,
    // appBarTheme: appBarTheme(),
    // fontFamily: "Muli",
    // textTheme: textTheme(),
    // inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  var outlineInputBorder = OutlineInputBorder(
      gapPadding: 10,
      borderRadius: BorderRadius.circular(32),
      borderSide: BorderSide(color: kTextColor));
  var outlineInputBorderError = OutlineInputBorder(
      gapPadding: 10,
      borderRadius: BorderRadius.circular(32),
      borderSide: BorderSide(color: Colors.redAccent));
      
  return InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
    errorBorder: outlineInputBorderError
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
      centerTitle: true,
      color: Colors.white,
      elevation: 0,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.black),
      textTheme: TextTheme(
          headline6: TextStyle(color: Color(0xFF888888), fontSize: 20)));
}
