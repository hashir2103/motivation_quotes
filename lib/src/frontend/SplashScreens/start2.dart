import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motivation_quotes/src/backend/ReminderPref.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/frontend/SplashScreens/SplashScreen.dart';
import 'package:motivation_quotes/src/frontend/_widgets/startButton.dart';

class StartScreen2 extends StatefulWidget {
  @override
  _StartScreen2State createState() => _StartScreen2State();
}

class _StartScreen2State extends State<StartScreen2>
    with SingleTickerProviderStateMixin {
  int notificationCount = 10;
  DateTime _startTime;
  DateTime _endTime;
  @override
  void initState() {
    initTimeSettings();
    saveNotificationCount(notificationCount);
    saveTimeValue();
    super.initState();
  }

  initTimeSettings() {
    DateTime now = DateTime.now();
    _startTime = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    _endTime =
        DateTime(now.year, now.month, now.day, now.hour + 11, now.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xFFe2f0f3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 40,
              child: ClipPath(
                clipper: DrawUpperClip(),
                child: Container(
                  decoration: BoxDecoration(gradient: kStart2GradientColor),
                ),
              )),
          Expanded(
              flex: 45,
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Set daily Motivation reminders.',
                        style: startText2,
                      ),
                      Container(
                        child: reminder(label: 'How Many', child: howManytime),
                      ),
                      Container(
                        child: reminder(
                            label: 'Start at',
                            child: GestureDetector(
                                onTap: () {
                                  pickTime(false);
                                },
                                child: timeInput(false))),
                      ),
                      Container(
                        child: reminder(
                            label: 'End at',
                            child: GestureDetector(
                                onTap: () {
                                  pickTime(true);
                                },
                                child: timeInput(true))),
                      ),
                    ]),
              )),
          Expanded(
            flex: 20,
            child: Stack(
              children: [
                ClipPath(
                  clipper: DrawBottomClip(),
                  child: Container(
                    decoration: BoxDecoration(gradient: kStart2GradientColor),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Buttons.startButton(
                        'Continue',
                        () {
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => SplashScreen()));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget reminder({String label, Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Color(0xFFd8dcdd), borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 55,
              child: Text(
                label,
                style: startText2,
              )),
          Expanded(flex: 45, child: child)
        ],
      ),
    );
  }

  Widget get howManytime => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            color: Color(0xFF464646),
            icon: Icon(FontAwesomeIcons.solidMinusSquare),
            onPressed: () {
              setState(() {
                if (notificationCount > 0) {
                  notificationCount = notificationCount - 1;
                }
                saveNotificationCount(notificationCount);
              });
            },
          ),
          Text(
            '${notificationCount}x',
            style: startText2,
          ),
          IconButton(
            color: Color(0xFF464646),
            icon: Icon(FontAwesomeIcons.solidPlusSquare),
            onPressed: () {
              setState(() {
                if (notificationCount < 20) {
                  notificationCount = notificationCount + 1;
                }
                saveNotificationCount(notificationCount);
              });
            },
          ),
        ],
      );

  Widget timeInput(bool endTime) => Container(
        padding: EdgeInsets.all(4),
        child: Center(
            child: Text(
          endTime
              ? '${_endTime.hour}:${_endTime.minute}'
              : '${_startTime.hour}:${_startTime.minute}',
          style: startText2small,
        )),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Color(0xFF474747)),
      );

  pickTime(bool endTime) async {
    DateTime now = DateTime.now();
    var time = await showTimePicker(
        context: context,
        initialTime: endTime
            ? TimeOfDay(hour: _endTime.hour, minute: _endTime.minute)
            : TimeOfDay(hour: _startTime.hour, minute: _startTime.minute),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });
    if (time != null) {
      setState(() {
        if (endTime == true) {
          _endTime =
              DateTime(now.year, now.month, now.day, time.hour, time.minute);
        } else {
          _startTime =
              DateTime(now.year, now.month, now.day, time.hour, time.minute);
        }
      });
    }
    saveTimeValue();
  }

  saveNotificationCount(value) async {
    await ReminderPrefs().setNotificationCount(value);
  }

  saveTimeValue() async {
    await ReminderPrefs().setstartTime(_startTime.toString());
    await ReminderPrefs().setendTime(_endTime.toString());
  }
}

class DrawUpperClip extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    var x = size.width;
    var y = size.height;
    path.lineTo(0, y * 0.9);
    var firstControlPoint = new Offset(x / 4, y);
    var firstEndPoint = new Offset(x / 2.25, y - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint = new Offset(x - (x / 3.25), y - 85);
    var secondEndPoint = new Offset(x, y - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(x, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}

class DrawBottomClip extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    var x = size.width;
    var y = size.height;
    path.lineTo(0, 0);
    path.quadraticBezierTo(x / 2.5, y / 2, x, 0);
    path.lineTo(x, y);
    path.lineTo(0, y);
    // path.lineTo(x, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
