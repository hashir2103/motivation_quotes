import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/AppConfigurations/size.dart';
import 'package:motivation_quotes/src/controller/Catergories/catergoryContoller.dart';
import 'package:provider/provider.dart';

class Catergory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var categoryBloc = Provider.of<CatergoryBloc>(context);
    SizeConfig.init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          slivers: [
            SliverSafeArea(
              minimum: EdgeInsets.only(top: 25),
              sliver: SliverAppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: kIconColor,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                pinned: true,
                backgroundColor: kPrimaryColor,
                title: Text("Catergories", style: appBarTitle),
                centerTitle: true,
              ),
            ),
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
                StreamBuilder<bool>(
                    stream: categoryBloc.general,
                    builder: (context, snapshot) {
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeGeneral(!snapshot.data);
                          },
                          child: catergory(
                              'General', FontAwesomeIcons.random, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.favourite,
                    builder: (context, snapshot) {
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeFavourite(!snapshot.data);
                          },
                          child: catergory(
                              'Favorite', FontAwesomeIcons.heart, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.hardtime,
                    builder: (context, snapshot) {
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeHardtimes(!snapshot.data);
                          },
                          child: catergory(
                              'Hard times', FontAwesomeIcons.blind, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.inspiration,
                    builder: (context, snapshot) {
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeInspiration(!snapshot.data);
                          },
                          child: catergory('Inspiration',
                              FontAwesomeIcons.lightbulb, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.love,
                    builder: (context, snapshot) {
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeLove(!snapshot.data);
                          },
                          child: catergory(
                              'Love', FontAwesomeIcons.gratipay, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.selfEsteem,
                    builder: (context, snapshot) {
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeSelfEsteem(!snapshot.data);
                          },
                          child: catergory('Self esteem',
                              FontAwesomeIcons.smileBeam, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.productivity,
                    builder: (context, snapshot) {
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeProductivity(!snapshot.data);
                          },
                          child: catergory(
                              'Productivity', FontAwesomeIcons.podcast, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.saying,
                    builder: (context, snapshot) {
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeSaying(!snapshot.data);
                          },
                          child: catergory(
                              'Saying', FontAwesomeIcons.comments, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.monday,
                    builder: (context, snapshot) {
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeMonday(!snapshot.data);
                          },
                          child: catergory(
                              'Monday', FontAwesomeIcons.meetup, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.future,
                    builder: (context, snapshot) {
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeFuture(!snapshot.data);
                          },
                          child: catergory(
                              'Future', FontAwesomeIcons.rocket, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.life,
                    builder: (context, snapshot) {
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeLife(!snapshot.data);
                          },
                          child: catergory(
                              'Life', FontAwesomeIcons.userFriends, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.workout,
                    builder: (context, snapshot) {
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeWorkout(!snapshot.data);
                          },
                          child: catergory(
                              'Workout', FontAwesomeIcons.bicycle, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.birthday,
                    builder: (context, snapshot) {
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeBirthday(!snapshot.data);
                          },
                          child: catergory('Birthday',
                              FontAwesomeIcons.birthdayCake, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.night,
                    builder: (context, snapshot) {
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeNight(!snapshot.data);
                          },
                          child:
                              catergory('Night', FontAwesomeIcons.moon, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.travel,
                    builder: (context, snapshot) {
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeTravel(!snapshot.data);
                          },
                          child:
                              catergory('Travel', FontAwesomeIcons.car, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.sport,
                    builder: (context, snapshot) {
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changeSport(!snapshot.data);
                          },
                          child: catergory(
                              'Sport', FontAwesomeIcons.solidFutbol, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.past,
                    builder: (context, snapshot) {
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changePast(!snapshot.data);
                          },
                          child: catergory(
                              'Past', FontAwesomeIcons.spinner, snapshot.data));
                    }),
                StreamBuilder<bool>(
                    stream: categoryBloc.passion,
                    builder: (context, snapshot) {
                      return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            categoryBloc.changePassion(!snapshot.data);
                          },
                          child: catergory(
                              'Passion', FontAwesomeIcons.child, snapshot.data));
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
              ):Container(),
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
