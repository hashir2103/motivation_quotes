
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';
import 'package:motivation_quotes/src/backend/sqliteDB.dart';
import 'package:motivation_quotes/src/controller/Notification/Notification_Manager.dart';
import 'package:motivation_quotes/src/controller/Notification/reminderController.dart';
import 'package:motivation_quotes/src/frontend/_widgets/SliverAppBar.dart';
import 'package:motivation_quotes/src/frontend/_widgets/customDailog.dart';
import 'package:provider/provider.dart';

class Reminder extends StatefulWidget {
  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  DateTime _startTime;
  DateTime _endTime;
  @override
  void initState() {
    var remBloc = Provider.of<ReminderBloc>(context, listen: false);
    super.initState();
    _startTime = DateTime.parse(remBloc.startTimeValue);
    _endTime = DateTime.parse(remBloc.endTimeValue);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var remBloc = Provider.of<ReminderBloc>(context);
    var nm = Provider.of<NotificationManager>(context);
    var db = Provider.of<SqliteDB>(context);

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          remBloc.saveValueToDB(db);
          remBloc.setUpNotificationReminer(db, nm, remBloc);
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: CustomScrollView(
            slivers: [
              MyAppBar(
                title: 'Daily Reminder',
                onPressed: () {
                  remBloc.saveValueToDB(db);
                  return Navigator.pop(context);
                },
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Card(
                    color: kPrimaryColor.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Set A Notification Reminder To Keep You Motivated!',
                        style: reminderAlert,
                        textAlign: TextAlign.center,
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: data(label: 'How Many', child: howManytime(remBloc)),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child:
                      data(label: 'Start at', child: timeInput(false, remBloc)),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: data(label: 'End at', child: timeInput(true, remBloc)),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child:
                      data(label: 'Type Of Quote', child: typeOfquote(remBloc)),
                ),
              ])),
            ],
          ),
        ),
      ),
    );
  }

  Widget data({String label, Widget child}) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xff434c51).withOpacity(0.4),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 50,
              child: Text(
                label,
                style: reminderText,
              )),
          Expanded(flex: 50, child: child)
        ],
      ),
    );
  }

  Widget howManytime(ReminderBloc remBloc) => StreamBuilder<int>(
      stream: remBloc.count,
      builder: (context, snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              color: kIconColor,
              icon: Icon(FontAwesomeIcons.solidMinusSquare),
              onPressed: () {
                if (snapshot.data > 0) {
                  remBloc.changeCount(snapshot.data - 1);
                }
              },
            ),
            Text(
              '${snapshot.data}x',
              style: reminderText,
            ),
            IconButton(
              color: kIconColor,
              icon: Icon(FontAwesomeIcons.solidPlusSquare),
              onPressed: () {
                if (snapshot.data < 20) {
                  remBloc.changeCount(snapshot.data + 1);
                }
              },
            ),
          ],
        );
      });

  pickTime(bool endTime, ReminderBloc remBloc) async {
    DateTime now = DateTime.now();
    var time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });
    if (time != null) {
      if (endTime == true) {
        DateTime pickedTime =
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
          _endTime =
              DateTime(now.year, now.month, now.day, time.hour, time.minute);
          remBloc.changeEndTime(_endTime.toString());
        }
      } else {
        DateTime pickedTime =
            DateTime(now.year, now.month, now.day, time.hour, time.minute);

        if (pickedTime.isAfter(_endTime)) {
          showDialog(
              context: context,
              builder: (context) {
                return CustomDailogBox(
                  description: 'Start time cannot be great than End time!',
                );
              });
        } else {
          if (pickedTime.isBefore(DateTime.now())) {
            _startTime = DateTime(
                now.year, now.month, now.day + 1, time.hour, time.minute);
            _endTime = DateTime(now.year, now.month, now.day + 1, _endTime.hour,
                _endTime.minute);
            remBloc.changeStartTime(_startTime.toString());
            remBloc.changeEndTime(_endTime.toString());
          } else {
            _startTime =
                DateTime(now.year, now.month, now.day, time.hour, time.minute);
            _endTime = DateTime(
                now.year, now.month, now.day, _endTime.hour, _endTime.minute);
            remBloc.changeStartTime(_startTime.toString());
            remBloc.changeEndTime(_endTime.toString());
          }
        }
      }
    }
  }

  Widget timeInput(bool endTime, ReminderBloc remBloc) => GestureDetector(
        onTap: () {
          pickTime(endTime, remBloc);
        },
        child: StreamBuilder<String>(
            stream: endTime ? remBloc.endTime : remBloc.startTime,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Center(
                    child: Text(
                  "${snapshot.data.split(' ')[1].substring(0, 5)}",
                  // "${snapshot.data.substring(0, 19)}",
                  style: reminderTextsmall,
                )),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), color: Colors.grey.withOpacity(0.4)),
              );
            }),
      );

  Widget typeOfquote(ReminderBloc remBloc) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            elevation: 0,
            isScrollControlled: true,
            isDismissible: false,
            backgroundColor: kPrimaryColor,
            context: context,
            builder: (context) {
              return CatList();
            });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(30), color: kIconColor),
            child: StreamBuilder<String>(
                stream: remBloc.typeOfquote,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return Center(
                    child: Text(
                      snapshot.data,
                      style: reminderTextsmall,
                    ),
                  );
                }),
          ),
          Icon(
            Icons.arrow_forward_ios_sharp,
            color: kIconColor,
          ),
        ],
      ),
    );
  }
}

class CatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var remBloc = Provider.of<ReminderBloc>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          toolbarHeight: 100,
          title: Padding(
            padding: const EdgeInsets.only(top: 17.0),
            child: Text(
              'Categories',
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
        ),
        body: ListView.builder(
            itemCount: catergories.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      remBloc.changeTypeOfQuote(catergories[index]);
                      Navigator.pop(context);
                    },
                    leading: Text(
                      catergories[index],
                      style: catergoryLabel,
                    ),
                  ),
                  Divider(
                    color: kIconColor,
                    thickness: 0.2,
                  ),
                ],
              );
            }),
      ),
    );
  }
}

List<String> catergories = [
  'Past',
  'Fitness',
  'Productivity',
  'love',
  'saying',
  'Monday',
  'life',
  'Inspiration',
  'Hard times',
  'future',
  'birthday',
  'Night',
  'Travel',
  'Sport',
  'Passion',
  'Self-Esteem',
];
