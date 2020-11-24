import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/backend/sqliteDB.dart';
import 'package:motivation_quotes/src/controller/Catergories/catergoryContoller.dart';
import 'package:motivation_quotes/src/controller/Catergories/catergoryModel.dart';
import 'package:motivation_quotes/src/controller/Quotes/quotesModel.dart';
import 'package:motivation_quotes/src/frontend/_widgets/BottomNavigationBar.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share/share.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Quote> quotes;
  Stream<bool> catStream;
  bool showFavHeart = false;

  @override
  void initState() {
    super.initState();
    var catBloc = Provider.of<CatergoryBloc>(context, listen: false);
    catStream = MergeStream<bool>([
      catBloc.general,
      catBloc.favourite,
      catBloc.hardtime,
      catBloc.inspiration,
      catBloc.love,
      catBloc.selfEsteem,
      catBloc.productivity,
      catBloc.saying,
      catBloc.monday,
      catBloc.future,
      catBloc.life,
      catBloc.workout,
      catBloc.birthday,
      catBloc.night,
      catBloc.travel,
      catBloc.sport,
      catBloc.past,
      catBloc.passion,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<SqliteDB>(context);
    return Scaffold(
      body: StreamBuilder<bool>(
          stream: catStream,
          builder: (context, snapshot) {
            print(snapshot.data);
            if (!snapshot.hasData) {
              return Body(
                db: db,
              );
            }
            return Body(
              db: db,
            );
          }),
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
    List<Quote> quotes;
    return StreamBuilder<Object>(
      stream: null,
      builder: (context, snapshot) {
        return getMyCategory(quotes);
      }
    );
  }

  FutureBuilder<List<CatergoryModel>> getMyCategory(List<Quote> quotes) {
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
            return getQuoteByCategory(mycat, quotes);
          });
  }

  FutureBuilder<List<Quote>> getQuoteByCategory(List<String> mycat, List<Quote> quotes) {
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
                  print('length : ${quotes.length}');
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
                              Text(
                                quotes[page].body,
                                style: quoteText,
                                textAlign: TextAlign.center,
                              ),
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
            // initialData: [Quote("", "", "", "")],
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
                      catBloc.changeQuote(fav);
                      db.updateQuote(
                          Quote(q.id, q.body, q.catergory, q.author, isFav: 1));
                    } else {
                      fav.remove(q);
                      catBloc.changeQuote(fav);
                      db.updateQuote(
                          Quote(q.id, q.body, q.catergory, q.author, isFav: 0));
                    }
                  },
                  child: (fav?.contains(q) ?? false)
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 40,
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
        Share.share(quote.body,
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