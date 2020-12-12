
import 'package:flutter/material.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/controller/collection/ProfileController.dart';
import 'package:motivation_quotes/src/frontend/_widgets/SliverAppBar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemes extends StatefulWidget {
  @override
  _AppThemesState createState() => _AppThemesState();
}

class _AppThemesState extends State<AppThemes> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  @override
  void initState() {
    // var ads = Provider.of<AdMobServices>(context, listen: false);
    // ads.loadRewardAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var profBloc = Provider.of<ProfileBloc>(context);
    // var ads = Provider.of<AdMobServices>(context);
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: CustomScrollView(
        slivers: [
          MyAppBar(title: 'Themes', onPressed: () => Navigator.pop(context)),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 0.55,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              return GestureDetector(
                onTap: () async {
                  // await ads.showRewardedAds();
                  var pref = await _pref;
                  pref.setString('theme', themesList[index]);
                  pref.setInt('themeTextStyle', index);
                  profBloc.changeTheme(themesList[index]);
                  profBloc.changeThemeText(themetextStyles[index]);
                  Navigator.pop(context);
                },
                child: Stack(
                  children: [
                    FractionallySizedBox(
                      heightFactor: 1,
                      widthFactor: 1,
                      child: Card(
                          elevation: 8,
                          child: Image(
                            image: AssetImage(
                                'assets/themes/${themesList[index]}'),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          'ABCD',
                          style: themetextStyles[index],
                        )),
                  ],
                ),
              );
            }, childCount: themesList.length),
          )
        ],
      ),
    ));
  }
}

List<String> themesList = [
  '1.jpg',
  '2.jpg',
  '3.jpg',
  '4.jpg',
  '5.jpg',
  '6.jpg',
  '7.jpg',
  '8.jpg',
  '9.jpg',
  '10.jpg',
  '11.jpg',
  '12.jpg',
  '13.jpg',
  '14.jpg',
  '15.jpg',
  '16.jpg',
  '17.jpg',
  '18.jpg',
  '19.jpg',
  '20.jpg',
  '1.jpeg',
];
