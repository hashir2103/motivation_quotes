import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motivation_quotes/src/controller/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/controller/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/controller/AppConfigurations/size.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      height: getProportionateScreenHeight(SizeConfig.screenHeight * 0.08),
      color: kPrimaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          navItems(icon: 'grid.svg', label: 'Catergories'),
          navItems(icon: 'theme.svg', label: 'Themes'),
          navItems(icon: 'Bell.svg', label: 'Reminder'),
          navItems(icon: 'User.svg', label: 'Profile'),
        ],
      ),
    );
  }

  navItems({@required String icon, @required String label}) {
    return Expanded(
        flex: 1,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          SvgPicture.asset(
            'assets/icons/$icon',
            color: Colors.white,
            height:
                getProportionateScreenHeight(SizeConfig.screenHeight * 0.03),
          ),
          Text(
            label,
            style: navText(),
          ),
        ]));
  }
}
