import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/backend/sqliteDB.dart';
import 'package:motivation_quotes/src/controller/Catergories/catergoryContoller.dart';
import 'package:motivation_quotes/src/controller/Catergories/catergoryModel.dart';
import 'package:motivation_quotes/src/controller/Notification/Notification_Manager.dart';
import 'package:motivation_quotes/src/controller/Notification/reminderController.dart';
import 'package:motivation_quotes/src/controller/Quotes/quotesModel.dart';
import 'package:motivation_quotes/src/controller/collection/ProfileController.dart';
import 'package:motivation_quotes/src/frontend/_widgets/BottomNavigationBar.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Quote> quotes;
  Stream<bool> catStream;
  bool showFavHeart = false;
  Timer timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<SqliteDB>(context);
    var nm = Provider.of<NotificationManager>(context);
    var remBloc = Provider.of<ReminderBloc>(context);
    var profBloc = Provider.of<ProfileBloc>(context);
    var catBloc = Provider.of<CatergoryBloc>(context);
    timer = Timer.periodic(Duration(days: 1),
        (timer) => remBloc.setUpNotificationReminer(db, nm, remBloc));
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<String>(
              stream: profBloc.apptheme,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                if (snapshot.data == null) {
                  return Container();
                }
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/themes/${snapshot.data}"),
                          fit: BoxFit.cover)),
                );
              }),
          StreamBuilder<bool>(
              stream: catBloc.catergoryStreamCombine,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CupertinoActivityIndicator());
                }
                if (!snapshot.data) {
                  return Center(
                      child: Text(
                    "General",
                    style: quoteText(10),
                  ));
                }
                return Body(
                  db: db,
                );
              }),
        ],
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key key,
    @required this.db,
  }) : super(key: key);

  final SqliteDB db;

  @override
  Widget build(BuildContext context) {
    var profBloc = Provider.of<ProfileBloc>(context);
    List<Quote> quotes;
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return getMyCategory(quotes, profBloc);
        });
  }

  FutureBuilder<List<CatergoryModel>> getMyCategory(
      List<Quote> quotes, ProfileBloc profileBloc) {
    return FutureBuilder(
        future: db.getMyCat(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          List<String> mycat = [];
          for (var snap in snapshot.data) {
            mycat.add(snap.catergoryName);
          }
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text(
                  "No Quote Found!",
                  style: startText,
                ),
              ),
            );
          }
          return getQuoteByCategory(mycat, quotes, profileBloc);
        });
  }

  FutureBuilder<List<Quote>> getQuoteByCategory(
      List<String> mycat, List<Quote> quotes, ProfileBloc profileBloc) {
    return FutureBuilder(
      future: db.getQuoteByCatergories(mycat),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: Text(
                "No Quote Found!",
                style: startText,
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          quotes = snapshot.data;
          return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: quotes.length,
              itemBuilder: (context, page) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Container()),
                      StreamBuilder<TextStyle>(
                          stream: profileBloc.appthemeText,
                          builder: (context, snapshot) {
                            return Text(
                              quotes[page].body,
                              style:
                                  (!snapshot.hasData && snapshot.data == null)
                                      ? quoteText(quotes[page].body.length)
                                      : snapshot.data,
                              textAlign: TextAlign.center,
                            );
                          }),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        '~${quotes[page].author}',
                        style: authorText,
                        textAlign: TextAlign.center,
                      ),
                      Expanded(child: Container()),
                      BottomButtons(
                        quote: quotes[page],
                      ),
                      SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                );
              });
        }
        return Container();
      },
    );
  }
}

class BottomButtons extends StatefulWidget {
  final Quote quote;

  const BottomButtons({Key key, this.quote}) : super(key: key);
  @override
  _BottomButtonsState createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  // List<Quote> fav = [];
  @override
  Widget build(BuildContext context) {
    var db = Provider.of<SqliteDB>(context);
    var catBloc = Provider.of<CatergoryBloc>(context);
    var q = widget.quote;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Container()),
        shareIcon(widget.quote),
        Expanded(child: Container()),
        StreamBuilder<List<Quote>>(
            stream: catBloc.quote,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                Container(
                  height: 0,
                  width: 0,
                );
              }
              var fav = snapshot.data;
              return GestureDetector(
                  onTap: () {
                    if (!fav.contains(q)) {
                      fav.add(q);
                      print('Adding : ${fav.length}');
                      catBloc.changeQuote(fav);
                      db.updateQuote(
                          Quote(q.id, q.body, q.catergory, q.author, isFav: 1));
                    } else {
                      fav.remove(q);
                      print('Removing : ${fav.length}');
                      catBloc.changeQuote(fav);
                      db.updateQuote(
                          Quote(q.id, q.body, q.catergory, q.author, isFav: 0));
                    }
                  },
                  child: (fav?.contains(q) ?? false)
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 35,
                        )
                      : SvgPicture.asset(
                          'assets/icons/heart.svg',
                          color: kIconColor,
                          height: 30,
                          width: 30,
                        ));
            }),
        Expanded(child: Container()),
      ],
    );
  }

  shareIcon(Quote quote) {
    return GestureDetector(
      onTap: () {
        final RenderBox box = context.findRenderObject();
        Share.share("${quote.body} \n ~${quote.author}",
            subject: "MyQuote",
            sharePositionOrigin: box.localToGlobal(Offset(0, 50)) & box.size);
        // Share.shareFiles(['/assets/themes/1.jpeg'],
        // text: quote.body,sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
        // );
      },
      child: Container(
        child: SvgPicture.asset(
          'assets/icons/share.svg',
          color: kIconColor,
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
