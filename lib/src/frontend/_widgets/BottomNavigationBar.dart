import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/AppConfigurations/size.dart';
import 'package:motivation_quotes/src/frontend/ProfileScreens/profile.dart';
import 'package:motivation_quotes/src/frontend/ReminderScreens/reminder.dart';
import 'package:motivation_quotes/src/frontend/ThemeScreens/appTheme.dart';
import 'package:motivation_quotes/src/frontend/catergoriesScreens/catergory.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      height: getProportionateScreenHeight(SizeConfig.screenHeight * 0.08),
      color: kPrimaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          navItems(
            context,
            Catergory(),
            icon: 'grid.svg',
            label: '  Catergories ',
          ),
          navItems(
            context,
            AppThemes(),
            icon: 'theme.svg',
            label: '     Themes     ',
          ),
          navItems(
            context,
            Reminder(),
            icon: 'Bell.svg',
            label: '   Reminder   ',
          ),
          navItems(
            context,
            Profile(),
            icon: 'User.svg',
            label: '      Profile      ',
          )
        ],
      ),
    );
  }

  navItems(context, Widget widget,
      {@required String icon, @required String label}) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            elevation: 0,
            isScrollControlled: true,
            isDismissible: false,
            backgroundColor: kPrimaryColor,
            context: context,
            builder: (context) {
              return widget;
            });
      },
      child: Container(
          width: MediaQuery.of(context).size.width/4,
          // padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/$icon',
                    color: Colors.white,
                    height: getProportionateScreenHeight(
                        SizeConfig.screenHeight * 0.03),
                  ),
                  Text(
                    label,
                    style: navText(),
                  ),
                ]),
          ),
        ),
      
    );
  }
}
