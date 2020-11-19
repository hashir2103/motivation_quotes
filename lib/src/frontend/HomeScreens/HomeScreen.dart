import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/backend/sqliteDB.dart';
import 'package:motivation_quotes/src/controller/Quotes/quotesModel.dart';
import 'package:motivation_quotes/src/frontend/_widgets/BottomNavigationBar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Quote> quotes;
  Directory dir;
  Box<Quote> quoteBox;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<SqliteDB>(context);
    return Scaffold(
      body: FutureBuilder(
        future: db.getQuotes(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (snapshot.hasData) {
            quotes = snapshot.data;
            return PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: quotes.length,
                itemBuilder: (context, page) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Container()),
                        Text(
                          quotes[page].body,
                          style: quoteText,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          '~${quotes[page].author}',
                          style: authorText,
                          textAlign: TextAlign.center,
                        ),
                        Expanded(child: Container()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: Container()),
                            myIcon('share.svg'),
                            Expanded(child: Container()),
                            myIcon('heart.svg'),
                            Expanded(child: Container()),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                  );
                });
          }
          return null;
        },
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  myIcon(String icon, {Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: SvgPicture.asset(
          'assets/icons/$icon',
          color: kIconColor,
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
