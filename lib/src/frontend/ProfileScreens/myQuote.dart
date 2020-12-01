import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/backend/sqliteDB.dart';
import 'package:motivation_quotes/src/controller/collection/ProfileController.dart';
import 'package:motivation_quotes/src/controller/collection/ownQuote.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'addOwnQuote.dart';

class MyQuote extends StatefulWidget {
  @override
  _MyQuoteState createState() => _MyQuoteState();
}

class _MyQuoteState extends State<MyQuote> {
  @override
  Widget build(BuildContext context) {
    var db = Provider.of<SqliteDB>(context);
    var profBloc = Provider.of<ProfileBloc>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(),
            flex: 1,
          ),
          Expanded(
            flex: 7,
            child: StreamBuilder<bool>(
                stream: profBloc.removeOwnQuote,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return FutureBuilder(
                      future: db.getOwnQuote(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null || snapshot.data.isEmpty) {
                          return myCarosuel(true, [1]);
                        }
                        var list = [
                          for (var i = 0; i < snapshot.data.length; i += 1) i
                        ];
                        return myCarosuel(false, list, quotes: snapshot.data);
                      });
                }),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => showDialog(
                      context: context, builder: (context) => AddOwnQuote()),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: kIconColor, width: 4),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: SvgPicture.asset(
                        'assets/icons/PlusIcon.svg',
                        color: kIconColor,
                        height: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget myCarosuel(bool isempty, List<int> items, {List<OwnQuote> quotes}) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          enableInfiniteScroll: false,
          height: MediaQuery.of(context).size.height * 0.7,
          scrollDirection: Axis.horizontal,
          enlargeCenterPage: true,
        ),
        items: isempty
            ? items.map((i) => placeHolder()).toList()
            : items.map((i) {
                return myBuilder(quote: quotes[i]);
              }).toList(),
      ),
    );
  }

  Widget placeHolder() {
    return Builder(builder: (context) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.8,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => showDialog(
                    context: context, builder: (context) => AddOwnQuote()),
                child: SvgPicture.asset(
                  'assets/icons/PlusIcon.svg',
                  color: kIconColor,
                  height: 70,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Write Your Own Thoughts\nThis will be only visble to you.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, color: Colors.grey),
              ),
            ],
          ));
    });
  }

  Widget myBuilder({OwnQuote quote}) {
    return Builder(
      builder: (BuildContext context) {
        var db = Provider.of<SqliteDB>(context);
        var profBloc = Provider.of<ProfileBloc>(context);
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        quote.quote,
                        style: favouriteQuoteText(quote.quote.length),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '~${quote.author}',
                        style: favauthorText,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            size: 35,
                            color: Colors.greenAccent,
                          ),
                          onPressed: () {
                            final RenderBox box = context.findRenderObject();
                            Share.share("${quote.quote} \n ~${quote.author}",
                                subject: "MyFavouriteQuote",
                                sharePositionOrigin:
                                    box.localToGlobal(Offset(0, 50)) &
                                        box.size);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                            size: 35,
                          ),
                          onPressed: () => showDialog(
                              context: context,
                              builder: (context) => AddOwnQuote(
                                    quote: quote.quote,
                                    author: quote.author,
                                  )),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 35,
                              color: Colors.redAccent,
                            ),
                            onPressed: () async {
                              await db.deleteOwnQuote(quote);
                              profBloc.changeRemoveOwnQuote(true);
                            }),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ));
      },
    );
  }
}
