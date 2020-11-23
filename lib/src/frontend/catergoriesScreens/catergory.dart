import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/AppConfigurations/constants.dart';
import 'package:motivation_quotes/src/AppConfigurations/size.dart';
import 'package:motivation_quotes/src/backend/sqliteDB.dart';
import 'package:motivation_quotes/src/controller/Catergories/catergoryContoller.dart';
import 'package:motivation_quotes/src/controller/Catergories/catergoryModel.dart';
import 'package:motivation_quotes/src/frontend/_widgets/SliverAppBar.dart';
import 'package:provider/provider.dart';

class Catergory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var categoryBloc = Provider.of<CatergoryBloc>(context);
    var db = Provider.of<SqliteDB>(context);
    SizeConfig.init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          slivers: [
            MyAppBar(title: 'Categories',onPressed: ()=>Navigator.pop(context),),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 30),
                topButton(),
                SizedBox(height: 40),
              ]),
            ),
            SliverGrid.count(
              childAspectRatio: 1.7,
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: [
                // StreamBuilder<bool>(
                //     stream: categoryBloc.general,
                //     builder: (context, snapshot) {
                //       if (!snapshot.hasData) {
                //         return Container();
                //       }
                //       return MaterialButton(
                //           padding: EdgeInsets.all(0),
                //           onPressed: () {
                //             categoryBloc.changeGeneral(!snapshot.data);
                //           },
                //           child: catergory('General', FontAwesomeIcons.random,
                //               snapshot.data));
                //     }),
                // StreamBuilder<bool>(
                //     stream: categoryBloc.favourite,
                //     builder: (context, snapshot) {
                //       if (!snapshot.hasData) {
                //         return Container();
                //       }
                //       return MaterialButton(
                //           padding: EdgeInsets.all(0),
                //           onPressed: () {
                //             categoryBloc.changeFavourite(!snapshot.data);
                //           },
                //           child: catergory('Favorite', FontAwesomeIcons.heart,
                //               snapshot.data));
                //     }),
                StreamBuilder<bool>(
                    stream: categoryBloc.hardtime,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeHardtimes(!snapshot.data);
                            db.updateCat(CatergoryModel(
                                catergoryName: kHardtimes,
                                showCatergory:
                                    (snapshot.data == true) ? 0 : 1));
                          },
                          child: catergory('Hard times', FontAwesomeIcons.blind,
                              snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.inspiration,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeInspiration(!snapshot.data);
                            db.updateCat(CatergoryModel(
                                catergoryName: kInspiration,
                                showCatergory:
                                    (snapshot.data == true) ? 0 : 1));
                          },
                          child: catergory('Inspiration',
                              FontAwesomeIcons.lightbulb, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.love,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeLove(!snapshot.data);
                            db.updateCat(CatergoryModel(
                                catergoryName: kLove,
                                showCatergory:
                                    (snapshot.data == true) ? 0 : 1));
                          },
                          child: catergory('Love', FontAwesomeIcons.gratipay,
                              snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.selfEsteem,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeSelfEsteem(!snapshot.data);
                            db.updateCat(CatergoryModel(
                                catergoryName: kSelfesteem,
                                showCatergory:
                                    (snapshot.data == true) ? 0 : 1));
                          },
                          child: catergory('Self esteem',
                              FontAwesomeIcons.smileBeam, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.productivity,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeProductivity(!snapshot.data);
                            db.updateCat(CatergoryModel(
                                catergoryName: kProductivity,
                                showCatergory:
                                    (snapshot.data == true) ? 0 : 1));
                          },
                          child: catergory('Productivity',
                              FontAwesomeIcons.podcast, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.saying,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeSaying(!snapshot.data);
                            db.updateCat(CatergoryModel(
                                catergoryName: kSaying,
                                showCatergory:
                                    (snapshot.data == true) ? 0 : 1));
                          },
                          child: catergory('Saying', FontAwesomeIcons.comments,
                              snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.monday,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeMonday(!snapshot.data);
                            db.updateCat(CatergoryModel(
                                catergoryName: kMonday,
                                showCatergory:
                                    (snapshot.data == true) ? 0 : 1));
                          },
                          child: catergory('Monday', FontAwesomeIcons.meetup,
                              snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.future,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeFuture(!snapshot.data);
                            db.updateCat(CatergoryModel(
                                catergoryName: kFuture,
                                showCatergory:
                                    (snapshot.data == true) ? 0 : 1));
                          },
                          child: catergory('Future', FontAwesomeIcons.rocket,
                              snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.life,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeLife(!snapshot.data);
                            db.updateCat(CatergoryModel(
                                catergoryName: kLife,
                                showCatergory:
                                    (snapshot.data == true) ? 0 : 1));
                          },
                          child: catergory('Life', FontAwesomeIcons.userFriends,
                              snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.workout,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeWorkout(!snapshot.data);
                            db.updateCat(CatergoryModel(
                                catergoryName: kFitness,
                                showCatergory:
                                    (snapshot.data == true) ? 0 : 1));
                          },
                          child: catergory('Workout', FontAwesomeIcons.bicycle,
                              snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.birthday,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeBirthday(!snapshot.data);
                            db.updateCat(CatergoryModel(
                                catergoryName: kBirthday,
                                showCatergory:
                                    (snapshot.data == true) ? 0 : 1));
                          },
                          child: catergory('Birthday',
                              FontAwesomeIcons.birthdayCake, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.night,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeNight(!snapshot.data);
                            db.updateCat(CatergoryModel(
                                catergoryName: kNight,
                                showCatergory:
                                    (snapshot.data == true) ? 0 : 1));
                          },
                          child: catergory(
                              'Night', FontAwesomeIcons.moon, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.travel,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeTravel(!snapshot.data);
                            db.updateCat(CatergoryModel(
                                catergoryName: kTravel,
                                showCatergory:
                                    (snapshot.data == true) ? 0 : 1));
                          },
                          child: catergory(
                              'Travel', FontAwesomeIcons.car, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.sport,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeSport(!snapshot.data);
                            db.updateCat(CatergoryModel(
                                catergoryName: kSport,
                                showCatergory:
                                    (snapshot.data == true) ? 0 : 1));
                          },
                          child: catergory('Sport',
                              FontAwesomeIcons.solidFutbol, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.past,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changePast(!snapshot.data);
                            db.updateCat(CatergoryModel(
                                catergoryName: kPast,
                                showCatergory:
                                    (snapshot.data == true) ? 0 : 1));
                          },
                          child: catergory(
                              'Past', FontAwesomeIcons.spinner, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.passion,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changePassion(!snapshot.data);
                            db.updateCat(CatergoryModel(
                                catergoryName: kPassion,
                                showCatergory:
                                    (snapshot.data == true) ? 0 : 1));
                          },
                          child: catergory('Passion', FontAwesomeIcons.child,
                              snapshot.data));
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget catergory(
    String label,
    IconData icon,
    bool show,
  ) {
    var size = SizeConfig.screenWidth;

    return Container(
      padding: EdgeInsets.only(bottom: 12, right: 12, left: 10, top: 6),
      decoration: BoxDecoration(
        gradient: kStartGradientColor,
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                label,
                style: catergoryLabel,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              show
                  ? Icon(
                      Icons.check_box,
                      color: kIconColor,
                      size: 30,
                    )
                  : Container(),
              Expanded(child: Container()),
              Expanded(
                child: Icon(
                  icon,
                  color: kIconColor,
                  size: size * 0.1,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  topButton() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: kStartGradientColor),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Make Your Own Mix",
            style: startText,
          ),
        ),
      ),
    );
  }
}
