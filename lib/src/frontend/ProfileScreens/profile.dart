import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/frontend/ProfileScreens/addOwnQuote.dart';
import 'package:motivation_quotes/src/frontend/ProfileScreens/favourite.dart';
import 'package:motivation_quotes/src/frontend/ProfileScreens/myQuote.dart';

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
              reverse: true,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Column(
                  children: [marker()],
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.17,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [fav(), own()],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                isFav? MyFav() : MyQuote()
              ],
            )));
  }

  AppBar myAppbar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      toolbarHeight: 100,
      title: Padding(
        padding: const EdgeInsets.only(top: 17.0),
        child: Text(
          'Collection',
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
