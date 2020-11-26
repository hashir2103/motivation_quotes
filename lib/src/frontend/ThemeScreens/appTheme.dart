import 'package:flutter/material.dart';
import 'package:motivation_quotes/src/controller/collection/ProfileController.dart';
import 'package:motivation_quotes/src/frontend/_widgets/SliverAppBar.dart';
import 'package:provider/provider.dart';

class AppThemes extends StatefulWidget {
  @override
  _AppThemesState createState() => _AppThemesState();
}

class _AppThemesState extends State<AppThemes> {
  List<ImageProvider> images = [];
  @override
  void initState() {
    for (var i in themesList) {
      images.add(AssetImage('assets/themes/$i'));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var profBloc = Provider.of<ProfileBloc>(context);
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: CustomScrollView(
        slivers: [
          MyAppBar(title: 'Themes', onPressed: () => Navigator.pop(context)),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 0.55,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              return GestureDetector(
                onTap: () {
                  profBloc.changeTheme(themesList[index]);
                  Navigator.pop(context);
                },
                child: Card(
                    elevation: 8,
                    child: Opacity(
                        opacity: 0.8,
                        child:
                            Image.asset('assets/themes/${themesList[index]}',fit: BoxFit.cover,))),
              );
            }, childCount: themesList.length),
          )
        ],
      ),
    ));
  }
}

List<String> themesList = [
  '1.jpg',
  '2.jpg',
  '3.jpg',
  '4.jpg',
  '5.jpg',
  '6.jpg',
  '7.jpg',
  '8.jpg',
  '9.jpg',
  '10.jpg',
  '11.jpg',
  '12.jpg',
  '13.jpg',
  '14.jpg',
  '15.jpg',
  '16.jpg',
  '17.jpg',
  '1.jpeg',
];
