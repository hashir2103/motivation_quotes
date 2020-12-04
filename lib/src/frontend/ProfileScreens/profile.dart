import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/AppConfigurations/constants.dart';
import 'package:motivation_quotes/src/controller/Quotes/quotesModel.dart';
import 'package:motivation_quotes/src/controller/collection/ProfileController.dart';
import 'package:motivation_quotes/src/frontend/_widgets/Policydailog.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wiredash/wiredash.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isFav = true;
  @override
  Widget build(BuildContext context) {
    var profBloc = Provider.of<ProfileBloc>(context);
    Quote quote = profBloc.getQuote;
    return Scaffold(
        appBar: myAppbar(context),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                // topButton(),
                SizedBox(
                  height: 25,
                ),
                listHeading('Collection'),
                tile(
                  FontAwesomeIcons.shareAltSquare,
                  Colors.green,
                  'Share Motivation',
                  () {
                    final RenderBox box = context.findRenderObject();
                    Share.share("${quote.body} \n ~${quote.author}",
                        subject: "MyQuote",
                        sharePositionOrigin:
                            box.localToGlobal(Offset(0, 50)) & box.size);
                  },
                ),
                tile(FontAwesomeIcons.heart, Colors.red, 'Favourite quotes',
                    () => Navigator.pushNamed(context, kMyFav),
                    show: false),
                tile(FontAwesomeIcons.pencilAlt, Colors.yellow, 'Add your Own',
                    () => Navigator.pushNamed(context, kOwnQuote),
                    show: false),
                listHeading('Help'),
                // tile(
                //   FontAwesomeIcons.thumbsUp,
                //   Colors.yellowAccent,
                //   'Review this app',
                //   () {},
                // ),
                tile(FontAwesomeIcons.comments, Colors.blue, 'Give us Feedback',
                    () => Wiredash.of(context).show()),
                listHeading('Follow Us'),
                tile(FontAwesomeIcons.instagram, Color(0xfffb3940), 'Instagram',
                    () => _launchUniversalLinkIos('https://instagram.com')),
                tile(FontAwesomeIcons.facebookF, Colors.blue, 'facebook',
                    () => _launchUniversalLinkIos('https://www.facebook.com/')),
                tile(FontAwesomeIcons.pinterestP, Colors.red, 'Pinterest',
                    () => _launchUniversalLinkIos('https://pinterest.com')),
                listHeading('Other'),
                ListTile(
                  title: Text('Privacy Policy', style: profileListTileText),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return PolicyDailog(mdfilename: 'privacy_policy.md');
                        });
                  },
                ),
                ListTile(
                  title:
                      Text('Terms and Conditions', style: profileListTileText),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return PolicyDailog(mdfilename: 'terms_conditions.md');
                        });
                  },    
                ),
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

  ListTile tile(IconData icon, Color color, String label, onTap,
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

  Future<void> _launchUniversalLinkIos(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          url,
          forceSafariVC: true,
        );
      }
    }
  }
}
