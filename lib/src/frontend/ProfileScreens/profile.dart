import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/frontend/ProfileScreens/addOwnQuote.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isFav = true;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppbar(context),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: ListView(
              // reverse: true,
              children: [
                SizedBox(
                  height: 10,
                ),
                topButton(),
                SizedBox(
                  height: 25,
                ),
                listHeading('Collection'),
                tile(
                  FontAwesomeIcons.shareAltSquare,
                  Colors.green,
                  'Share Motivation',
                  () {},
                ),
                tile(FontAwesomeIcons.heart, Colors.red, 'Favourite quotes',
                    () {},show: false),
                tile(FontAwesomeIcons.pencilAlt, Colors.yellow, 'Add your Own',
                    () {},show: false),
                tile(FontAwesomeIcons.filter, Colors.yellow,
                    'Content Preference', () {},show: false),
                listHeading('Help'),
                tile(
                  FontAwesomeIcons.thumbsUp,
                  Colors.yellowAccent,
                  'Review this app',
                  () {},
                ),
                tile(FontAwesomeIcons.comments, Colors.blue, 'Give us Feedback',
                    () {}),
                listHeading('Follow Us'),
                tile(
                  FontAwesomeIcons.instagram,
                  Color(0xfffb3940),
                  'Instagram',
                  () {},
                ),
                tile(
                    FontAwesomeIcons.facebookF, Colors.blue, 'facebook', () {}),
                tile(FontAwesomeIcons.pinterestP, Colors.red, 'Pinterest',
                    () {}),
              ],
            )));
  }

  topButton() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: kGoldGradientColor),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Text(
            "Go Premium",
            style:
                GoogleFonts.ubuntu(fontSize: 22, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  listHeading(String heading) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Text(
        heading,
        style: reminderTextsmall,
      ),
    );
  }

  ListTile tile(IconData icon, Color color, String label, Function onTap,
      {show = true}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 1),
      onTap: onTap,
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        label,
        style: profileListTileText,
      ),
      trailing: show
          ? SizedBox(
              width: 0,
            )
          : Icon(
              Icons.arrow_forward_ios,
              color: kIconColor,
            ),
    );
  }

  AppBar myAppbar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      toolbarHeight: 100,
      title: Padding(
        padding: const EdgeInsets.only(top: 17.0),
        child: Text(
          'Profile',
          style: appBarTitle,
        ),
      ),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(top: 17.0),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kIconColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  static const _alignments = [
    Alignment.topLeft,
    Alignment.topRight,
  ];

  AlignmentGeometry _alignment() => _alignments[index];

  Widget marker() {
    var width = MediaQuery.of(context).size.width;
    return AnimatedAlign(
      duration: Duration(milliseconds: 250),
      alignment: _alignment(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey),
        height: 1,
        width: width / 2.6,
      ),
    );
  }

  Widget fav() {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          isFav = true;
          index = 0;
        });
      },
      child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          height: isFav ? 120 : 100,
          width: isFav ? width / 2.4 : width / 2.5,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_border_sharp,
                color: Colors.red,
                size: 40,
              ),
              Text(
                'Favourite',
                style: favouriteText,
              )
            ],
          )),
    );
  }

  Widget own() {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          isFav = false;
          index = 1;
        });
      },
      onDoubleTap: () {
        showDialog(
          context: context,
          builder: (context) => AddOwnQuote(),
        );
      },
      child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          height: isFav ? 100 : 120,
          width: isFav ? width / 2.5 : width / 2.4,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.note_add_sharp,
                color: Colors.green,
                size: 40,
              ),
              Text(
                'My Quotes',
                style: favouriteText,
              )
            ],
          )),
    );
  }
}
