import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motivation_quotes/src/AppConfigurations/constants.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/backend/sqliteDB.dart';
import 'package:motivation_quotes/src/controller/Notification/Notification.dart';
import 'package:motivation_quotes/src/controller/Notification/Notification_Manager.dart';
import 'package:motivation_quotes/src/controller/Notification/reminderModel.dart';
import 'package:motivation_quotes/src/frontend/SplashScreens/SplashScreen.dart';
import 'package:motivation_quotes/src/frontend/_widgets/customDailog.dart';
import 'package:motivation_quotes/src/frontend/_widgets/startButton.dart';
import 'package:provider/provider.dart';

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
    var db = Provider.of<SqliteDB>(context, listen: false);
    initTimeSettings(db);
    super.initState();
  }

  initTimeSettings(SqliteDB db) {
    DateTime now = DateTime.now();
    if (now.hour < 12) {
      _startTime =
          DateTime(now.year, now.month, now.day, now.hour + 1, now.minute);
      _endTime =
          DateTime(now.year, now.month, now.day, now.hour + 10, now.minute);
    } else if (now.hour > 12 && now.hour < 18) {
      _startTime =
          DateTime(now.year, now.month, now.day, now.hour , now.minute+30);
      _endTime =
          DateTime(now.year, now.month, now.day, now.hour , now.minute+330);
    } else {
      _startTime =
          DateTime(now.year, now.month, now.day+1, now.hour + 1 , now.minute);
      _endTime =
          DateTime(now.year, now.month, now.day+1, now.hour + 10, now.minute);
    }
    var reminder = ReminderModel(
        key: 1,
        reminderCount: notificationCount,
        startTime: _startTime.toString(),
        endTime: _endTime.toString(),
        typeOfquote: kLove,
        isUsingAppFirstTime: 1);
    db.addReminder(reminder);
  }

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<SqliteDB>(context);
    var notificationSchedule = Provider.of<NotificationManager>(context);
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
                        () async {
                          var reminder = ReminderModel(
                              key: 1,
                              reminderCount: notificationCount,
                              startTime: _startTime.toString(),
                              endTime: _endTime.toString(),
                              typeOfquote: kLove,
                              isUsingAppFirstTime: 1);
                          db.updateReminder(reminder);
                          var listquote = await db.getQuoteByCatergory(kLove);
                          List<AppNotification> listNotification = [];
                          for (var i = 0; i < notificationCount; i++) {
                            listNotification.add(AppNotification(
                                notificationID: i,
                                notificationTitle: "Daily Motivation",
                                notificationBody: listquote[i].body,
                                channel: NotificationManager
                                    .scheduledNotificationChannels[0]));
                          }
                          notificationSchedule.scheduleNotification(
                              listNotification, db);
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
      if (endTime == true) {
        var pickedTime =
            DateTime(now.year, now.month, now.day, time.hour, time.minute);
        if (pickedTime.isBefore(_startTime)) {
          showDialog(
              context: context,
              builder: (context) {
                return CustomDailogBox(
                  description: 'End time cannot be less than Start time!',
                );
              });
        } else {
          setState(() {
            _endTime = pickedTime;
          });
        }
      } else {
        var pickedTime =
            DateTime(now.year, now.month, now.day, time.hour, time.minute);
        if (pickedTime.isAfter(_endTime)) {
          showDialog(
              context: context,
              builder: (context) {
                return CustomDailogBox(
                  description: 'Start time cannot great than End time!',
                );
              });
        } else {
          setState(() {
            if (pickedTime.isBefore(DateTime.now())) {
              _startTime = DateTime(
                  now.year, now.month, now.day + 1, time.hour, time.minute);
              _endTime = DateTime(now.year, now.month, now.day + 1,
                  _endTime.hour, _endTime.minute);
            } else {
              _startTime = DateTime(
                  now.year, now.month, now.day, time.hour, time.minute);
              _endTime = DateTime(
                  now.year, now.month, now.day, _endTime.hour, _endTime.minute);
            }
          });
        }
      }
    }
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
