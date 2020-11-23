import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:motivation_quotes/src/backend/sqliteDB.dart';
import 'package:rxdart/rxdart.dart';
import 'Notification_Channel.dart';
import 'Notification.dart' as custom;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  AndroidInitializationSettings initializationSettingsAndroid;
  IOSInitializationSettings initializationSettingsIOS;
  InitializationSettings initializationSettings;
  BehaviorSubject<custom.AppNotification> _didRecieveNotification =
      BehaviorSubject<custom.AppNotification>();

  dispose() {
    _didRecieveNotification.close();
  }

  static final List<NotificationChannel> scheduledNotificationChannels = [
    NotificationChannel(
        channelID: "Motivation",
        channelDescription: "Motivation Quote",
        channelName: "Motivation",
        // soundName: "hijoz_azoni",
        hasSound: true),
    NotificationChannel(
        channelID: "Misr azoni",
        channelDescription: "Misr azoni yangarashi uchun",
        channelName: "Misr azoni channel",
        soundName: "misr_azoni",
        hasSound: true),
    NotificationChannel(
        channelID: "Custom",
        channelDescription: "Custom sound yangarashi uchun",
        channelName: "Custom sound channel",
        soundName: "slow_spring_board",
        hasSound: true),
    NotificationChannel(
        channelID: "No Sound",
        channelDescription: "No sound from the channel",
        channelName: "No sound channel",
        soundName: "slow_spring_board",
        hasSound: false),
  ];

  Future<void> initTimeZone() async {
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
  }

  NotificationManager.initNotificationManager() {
    tz.initializeTimeZones();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) async {
      var notification = custom.AppNotification(
          notificationID: id,
          notificationTitle: title,
          notificationBody: body,
          channel: scheduledNotificationChannels[0]);
      _didRecieveNotification.add(notification);
    });
    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  }

  setOnNotificationRecieve(Function onNoticationRecieve) {
    _didRecieveNotification.listen((notification) {
      onNoticationRecieve(notification);
    });
  }

  setOnNotificationClick(Function onNoticationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      onNoticationClick(payload);
    });
  }

  Future<void> scheduleNotification(
      List<custom.AppNotification> notifications, SqliteDB db) async {
    var timeList = await scheduleTimeList(db);
    for (int i = 0; i < timeList.length; i++) {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        notifications[i].channel.channelID,
        notifications[i].channel.channelName,
        notifications[i].channel.channelDescription,
        icon: 'app_icon',
        sound: RawResourceAndroidNotificationSound(
            notifications[i].channel.soundName),
        // largeIcon: DrawableResourceAndroidBitmap('app_icon'),
        // maxProgress: 2,
        autoCancel: false,
        enableLights: true,
        playSound: notifications[i].channel.hasSound,
        // color: Colors.green,
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        ledOnMs: 1000,
        ledOffMs: 500
      );

      var iOSPlatformChannelSpecifics =
          IOSNotificationDetails(sound: 'slow_spring_board.aiff');

      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.zonedSchedule(
          notifications[i].notificationID,
          notifications[i].notificationTitle,
          notifications[i].notificationBody,
          timeList[i],
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  Future<List<tz.TZDateTime>> scheduleTimeList(SqliteDB db) async {
    List<tz.TZDateTime> timeList = [];
    var rem = await db.getReminder();
    var notificationCount = rem.reminderCount;
    var startTime = rem.startTime.substring(0,19);
    var endTime = rem.endTime.substring(0,19);
    var tzStartTime = tz.TZDateTime.parse(tz.local, startTime);
    var tzEndTime = tz.TZDateTime.parse(tz.local, endTime);
    var diff = tzEndTime.difference(tzStartTime);
    var diffInMircoseconds = (diff.inMicroseconds / notificationCount).ceil();
    var duration = Duration(microseconds: diffInMircoseconds);
    for (int i = 1; i < notificationCount +1; i++) {
      timeList.add(tzStartTime.add(duration * i));
    }
    return timeList;
  }

  Future<void> repeatNotification(custom.AppNotification notification) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      notification.channel.channelID,
      notification.channel.channelName,
      notification.channel.channelDescription,
      icon: 'app_icon',
      sound:
          RawResourceAndroidNotificationSound(notification.channel.soundName),
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
      autoCancel: false,
      enableLights: true,
      playSound: notification.channel.hasSound,
    );

    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'slow_spring_board.aiff');

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.periodicallyShow(
      notification.notificationID,
      notification.notificationTitle,
      notification.notificationBody,
      RepeatInterval.everyMinute,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
    );
  }

  pendingNotifications() async {
    List<PendingNotificationRequest> request =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return request;
  }

  // to show notification on spot
  Future<void> showNotification(custom.AppNotification notification) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high, playSound: true);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        notification.notificationID,
        notification.notificationTitle,
        notification.notificationBody,
        platformChannelSpecifics,
        payload: 'item x');
  }
}
