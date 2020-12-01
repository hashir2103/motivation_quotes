import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/backend/sqliteDB.dart';
import 'package:motivation_quotes/src/controller/collection/ownQuote.dart';
import 'package:motivation_quotes/src/frontend/_widgets/customDailog.dart';
import 'package:provider/provider.dart';

class AddOwnQuote extends StatefulWidget {
  final String quote;
  final String author;
  AddOwnQuote({this.quote = '', this.author = ''});
  @override
  _AddOwnQuoteState createState() => _AddOwnQuoteState();
}

class _AddOwnQuoteState extends State<AddOwnQuote> {
  TextEditingController _quote;
  TextEditingController _author;
  @override
  void dispose() {
    _author.dispose();
    _quote.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _quote = TextEditingController(text: widget.quote);
    _author = TextEditingController(text: widget.author);
    var _width = MediaQuery.of(context).size.width;
    var db = Provider.of<SqliteDB>(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: _width,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: Color(0xff434c51),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                      child: Text(
                    widget.quote == ''?
                    'Add New Quote'
                    :'Edit Quote',
                    style: GoogleFonts.yrsa(color: kIconColor, fontSize: 28),
                  )),
                ),
                IconButton(
                    icon: Icon(
                      CupertinoIcons.multiply,
                      color: kIconColor,
                    ),
                    onPressed: () => Navigator.pop(context)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _quote,
                maxLines: 3,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                    hintText: 'Quote',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _author,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                    hintText: 'Author(Optional)',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                if (_quote.text.isNotEmpty) {
                  var quote = OwnQuote(
                      quote: _quote.text,
                      author: (_author.text.isEmpty) ? '' : _author.text);
                  db.addOwnQuote(quote);
                  Navigator.pop(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDailogBox(
                        description: 'Quote cannot be empty!',
                      );
                    },
                  );
                }
              },
              child: Container(
                width: _width * 0.8,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: kPrimaryGradientColor,
                ),
                child: Center(
                    child: Text(
                  "save",
                  style: appBarTitle,
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
