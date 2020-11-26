import 'package:flutter/material.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';

// ignore: must_be_immutable
class MyAppBar extends StatelessWidget {
  String title;
  Function onPressed;
  MyAppBar({@required this.title,@required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      minimum: EdgeInsets.only(top: 35),
      sliver: SliverAppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kIconColor,
          ),
          onPressed: onPressed,
        ),
        pinned: true,
        backgroundColor: kPrimaryColor,
        title: Text(title, style: appBarTitle),
        centerTitle: true,
      ),
    );
  }
}
