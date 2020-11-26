import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/AppConfigurations/constants.dart';
import 'package:motivation_quotes/src/backend/sqliteDB.dart';
import 'package:motivation_quotes/src/controller/Catergories/catergoryContoller.dart';
import 'package:motivation_quotes/src/controller/collection/ProfileController.dart';
import 'package:motivation_quotes/src/controller/Quotes/quotesModel.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isFav = true;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<SqliteDB>(context);
    var profBloc = Provider.of<ProfileBloc>(context);
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
                myFavourite(profBloc, db),
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

  StreamBuilder<bool> myFavourite(ProfileBloc profBloc, SqliteDB db) {
    return StreamBuilder<bool>(
        stream: profBloc.removeFav,
        builder: (context, snapshot) {
          return FutureBuilder<List<Quote>>(
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
                print('loop iteration : $i');
                return myBuilder(quotes[i]);
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
                onTap: () =>
                    Navigator.pushReplacementNamed(context, kHomeScreen),
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
                isFav
                    ? 'Add Favourite Quotes To Your Collection.'
                    : 'Write Your Own Thoughts\nThis will be only visble to you.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, color: Colors.grey),
              ),
            ],
          ));
    });
  }

  Widget myBuilder(Quote quote) {
    print('Data : ${quote.body}');
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
                      Text(
                        quote.body,
                        style: favouriteQuoteText,
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
