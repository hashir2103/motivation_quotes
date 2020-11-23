import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/AppConfigurations/constants.dart';
import 'package:motivation_quotes/src/AppConfigurations/size.dart';
import 'package:motivation_quotes/src/backend/sqliteDB.dart';
import 'package:motivation_quotes/src/controller/Catergories/catergoryModel.dart';
import 'package:motivation_quotes/src/frontend/SplashScreens/start2.dart';
import 'package:motivation_quotes/src/frontend/_widgets/startButton.dart';
import 'package:provider/provider.dart';

class StartScreen3 extends StatefulWidget {
  @override
  _StartScreen3State createState() => _StartScreen3State();
}

class _StartScreen3State extends State<StartScreen3>
    with SingleTickerProviderStateMixin {
  List<bool> tap = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<SqliteDB>(context);
    return Scaffold(
      backgroundColor: Color(0xFFf4dee0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 40,
              child: ClipPath(
                clipper: DrawUpperClip(),
                child: Container(
                  decoration: BoxDecoration(gradient: kStart3GradientColor),
                ),
              )),
          Expanded(
              flex: 45,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(children: [
                        Text(
                          'What type of Motivation do you want?',
                          style: startText2,
                          textAlign: TextAlign.center,
                        ),
                      ]),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tap[0] = !tap[0];
                                    });
                                  },
                                  child:
                                      categoryContainer('Inspiration', tap[0])),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tap[1] = !tap[1];
                                    });
                                  },
                                  child: categoryContainer(
                                      'Productivity', tap[1])),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tap[2] = !tap[2];
                                    });
                                  },
                                  child: categoryContainer('Love', tap[2])),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tap[3] = !tap[3];
                                    });
                                  },
                                  child:
                                      categoryContainer('Self-esteem', tap[3])),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tap[4] = !tap[4];
                                    });
                                  },
                                  child:
                                      categoryContainer('Hard times', tap[4])),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tap[5] = !tap[5];
                                    });
                                  },
                                  child: categoryContainer(
                                      'Sports & fitness', tap[5])),
                            ],
                          ),
                        ],
                      )
                    ]),
              )),
          Expanded(
            flex: 20,
            child: Stack(
              children: [
                ClipPath(
                  clipper: DrawBottomClip(),
                  child: Container(
                    decoration: BoxDecoration(gradient: kStart3GradientColor),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Buttons.startButton(
                        'Continue',
                        () {
                          List<CatergoryModel> cats = [
                            CatergoryModel(
                                catergoryName: kPast, showCatergory: 0),
                            CatergoryModel(
                                catergoryName: kFitness,
                                showCatergory: tap[5] == true ? 1 : 0),
                            CatergoryModel(
                                catergoryName: kProductivity,
                                showCatergory: tap[1] == true ? 1 : 0),
                            CatergoryModel(
                                catergoryName: kLove,
                                showCatergory: tap[2] == true ? 1 : 0),
                            CatergoryModel(
                                catergoryName: kSaying, showCatergory: 0),
                            CatergoryModel(
                                catergoryName: kMonday, showCatergory: 0),
                            CatergoryModel(
                                catergoryName: kLife, showCatergory: 0),
                            CatergoryModel(
                                catergoryName: kInspiration,
                                showCatergory: tap[0] == true ? 1 : 0),
                            CatergoryModel(
                                catergoryName: kHardtimes,
                                showCatergory: tap[4] == true ? 1 : 0),
                            CatergoryModel(
                                catergoryName: kFuture, showCatergory: 0),
                            CatergoryModel(
                                catergoryName: kBirthday, showCatergory: 0),
                            CatergoryModel(
                                catergoryName: kNight, showCatergory: 0),
                            CatergoryModel(
                                catergoryName: kTravel, showCatergory: 0),
                            CatergoryModel(
                                catergoryName: kSport, showCatergory: 0),
                            CatergoryModel(
                                catergoryName: kSelfesteem,
                                showCatergory: tap[3] == true ? 1 : 0),
                            CatergoryModel(
                                catergoryName: kPassion, showCatergory: 0),
                          ];
                          for (var cat in cats) {
                            db.addCat(cat);
                          }
                          print('catergory added!..');
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => StartScreen2()));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  categoryContainer(String label, bool istap) {
    var x = SizeConfig.screenWidth * 0.4;
    var y = SizeConfig.screenHeight * 0.1;
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      width: x,
      height: y,
      decoration: BoxDecoration(
        color: istap ? Color(0xff474747) : Color(0xffdcd8d9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          label,
          style: startText2,
        ),
      ),
    );
  }
}

class DrawUpperClip extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    var x = size.width;
    var y = size.height;
    path.lineTo(0, y * 0.9);
    var firstControlPoint = new Offset(x / 4, y);
    var firstEndPoint = new Offset(x / 2.25, y - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint = new Offset(x - (x / 3.25), y - 85);
    var secondEndPoint = new Offset(x, y - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(x, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}

class DrawBottomClip extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    var x = size.width;
    var y = size.height;
    path.lineTo(0, 0);
    path.quadraticBezierTo(x / 2.5, y / 2, x, 0);
    path.lineTo(x, y);
    path.lineTo(0, y);
    // path.lineTo(x, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
