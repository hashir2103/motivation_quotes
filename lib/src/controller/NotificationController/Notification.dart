import 'package:flutter/foundation.dart';
import 'package:motivation_quotes/src/controller/NotificationController/Notification_Channel.dart';


class AppNotification {
  final int notificationID;
  final String notificationTitle;
  final String notificationBody;
  final NotificationChannel channel;

  AppNotification(
      {@required this.notificationID,
      @required this.notificationTitle,
      @required this.notificationBody,
      @required this.channel
      });
}