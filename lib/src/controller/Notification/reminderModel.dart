import 'package:flutter/foundation.dart';

class ReminderModel {
    ReminderModel({
      @required this.key,
      @required this.reminderCount,
      @required this.startTime,
      @required this.endTime,
      @required this.typeOfquote,
      @required this.isUsingAppFirstTime,
    });

    int key;
    int reminderCount;
    String startTime;
    String endTime;
    String typeOfquote;
    int isUsingAppFirstTime;

    factory ReminderModel.fromMap(Map<String, dynamic> json) => ReminderModel(
        key: json["key"],
        reminderCount: json["reminderCount"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        typeOfquote: json["typeOfquote"],
        isUsingAppFirstTime: json["isUsingAppFirstTime"],
    );

    Map<String, dynamic> toMap() => {
        "key": key,
        "reminderCount": reminderCount,
        "startTime": startTime,
        "endTime": endTime,
        "typeOfquote": typeOfquote,
        "isUsingAppFirstTime": isUsingAppFirstTime,
    };
}