import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/AppConfigurations/constants.dart';
import 'package:motivation_quotes/src/backend/sqliteDB.dart';
import 'package:motivation_quotes/src/controller/Catergories/catergoryContoller.dart';
import 'package:motivation_quotes/src/controller/Quotes/quotesModel.dart';
import 'package:motivation_quotes/src/controller/collection/ProfileController.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class MyFav extends StatefulWidget {
  @override
  _MyFavState createState() => _MyFavState();
}

class _MyFavState extends State<MyFav> {
  @override
  Widget build(BuildContext context) {
    var db = Provider.of<SqliteDB>(context);
    var profBloc = Provider.of<ProfileBloc>(context);
    return StreamBuilder<bool>(
        stream: profBloc.removeFav,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return FutureBuilder(
              future: db.getFav(),
              builder: (context, snapshot) {
                if (snapshot.data == null || snapshot.data.isEmpty) {
                  return myCarosuel(true, [1]);
                }
                var list = [
                  for (var i = 0; i < snapshot.data.length; i += 1) i
                ];
                return myCarosuel(false, list, quotes: snapshot.data);
              });
        });
  }

  Widget myCarosuel(bool isempty, List<int> items, {List<Quote> quotes}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: CarouselSlider(
        options: CarouselOptions(
          enableInfiniteScroll: false,
          height: MediaQuery.of(context).size.height * 0.5,
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
                onTap: () => Navigator.pushReplacementNamed(context, kHomeScreen),
                child: SvgPicture.asset(
                  'assets/icons/PlusIcon.svg',
                  color: kIconColor,
                  height: 70,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text('Add Favourite Quotes To Your Collection.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, color: Colors.grey),
              ),
            ],
          ));
    });
  }

  Widget myBuilder({Quote quote}) {
    return Builder(
      builder: (BuildContext context) {
        var db = Provider.of<SqliteDB>(context);
        var profBloc = Provider.of<ProfileBloc>(context);
        var catBloc = Provider.of<CatergoryBloc>(context);
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
                      Text(quote.body ,
                        style: favouriteQuoteText,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text('~${quote.author}',
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
                            Share.share("${quote.body} \n ~${quote.author}",
                                subject: "MyFavouriteQuote",
                                sharePositionOrigin:
                                    box.localToGlobal(Offset(0, 50)) &
                                        box.size);
                          },
                        ), 
                        IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 35,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                                    profBloc.changeRemoveFav(true);
                                    List<Quote> list = [];
                                    db.updateQuote(Quote(quote.id, quote.body,
                                        quote.catergory, quote.author,
                                        isFav: 0));
                                    var l = catBloc.quoteListValue;
                                    for (var i = 0; i < l.length; i++) {
                                      if (l[i].body == quote.body) {
                                      } else {
                                        list.add(l[i]);
                                      }
                                    }
                                    catBloc.changeQuote(list);
                                  }
                              ),
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
