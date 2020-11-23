import 'package:motivation_quotes/src/backend/sqliteDB.dart';
import 'package:motivation_quotes/src/controller/Notification/Notification.dart';
import 'package:motivation_quotes/src/controller/Notification/Notification_Manager.dart';
import 'package:motivation_quotes/src/controller/Notification/reminderModel.dart';
import 'package:rxdart/rxdart.dart';

class ReminderBloc {
  final _count = BehaviorSubject<int>();
  final _startTime = BehaviorSubject<String>();
  final _endTime = BehaviorSubject<String>();
  final _typeOfquote = BehaviorSubject<String>();

  //stream
  Stream<int> get count => _count.stream;
  Stream<String> get startTime => _startTime.stream;
  Stream<String> get endTime => _endTime.stream;
  Stream<String> get typeOfquote => _typeOfquote.stream;

  //setter
  Function(int) get changeCount => _count.sink.add;
  Function(String) get changeStartTime => _startTime.sink.add;
  Function(String) get changeEndTime => _endTime.sink.add;
  Function(String) get changeTypeOfQuote => _typeOfquote.sink.add;

  //functions
  String get endTimeValue => _endTime.value;
  String get startTimeValue => _startTime.value;
  int get countValue => _count.value;
  String get typeOfQuoteValue => _typeOfquote.value;

  saveValueToDB(SqliteDB db) {
    db.updateReminder(ReminderModel(
        key: 1,
        reminderCount: _count.value,
        startTime: _startTime.value,
        endTime: _endTime.value,
        typeOfquote: _typeOfquote.value,
        isUsingAppFirstTime: 1));
  }

  setUpNotificationReminer(SqliteDB db, NotificationManager nm,ReminderBloc remBloc) async {
    var listquote = await db.getQuoteByCatergory(_typeOfquote.value);
    List<AppNotification> listNotification = [];
    for (var i = 0; i < _count.value; i++) {
      listNotification.add(AppNotification(
          notificationID: i,
          notificationTitle: "Daily Motivation",
          notificationBody: listquote[i].body,
          channel: NotificationManager.scheduledNotificationChannels[0]));
    }
    nm.scheduleNotification(listNotification, db);
  }

  dispose() {
    _count.close();
    _startTime.close();
    _endTime.close();
    _typeOfquote.close();
  }
}
