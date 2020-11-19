// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:motivation_quotes/src/controller/Quotes/quotes.dart';
// import 'package:path_provider/path_provider.dart';

// class QuoteDB {
//   init() async {
//     Directory dir = await getApplicationDocumentsDirectory();
//     Hive.init(dir.path);
//     Hive.registerAdapter(QuoteAdapter());
//   }

//   addQuote({@required Quote quote, @required String boxName}) async {
//     var box = await Hive.openBox<Quote>(boxName);

//     // box.put("custom_key", logMap);
//     int idOfInput = await box.add(quote);

//     close();

//     return idOfInput;
//   }

//   // updateLogs(int i, Log newLog) async {
//   //   var box = await Hive.openBox(kQuoteBox);

//   //   var newLogMap = newLog.toMap(newLog);

//   //   box.putAt(i, newLogMap);

//   //   close();
//   // }

//   Future<Quote> getQuote({@required String boxName, @required int key}) async {
//     var box = await Hive.openBox(boxName);
//     return box.get(key);
//   }

//   Future<List<Quote>> getLogs({@required String boxName}) async {
//     var box = await Hive.openBox(boxName);

//     List<Quote> logList = [];

//     for (int i = 0; i < box.length; i++) {
//       var quote = box.getAt(i);

//       logList.add(quote);
//     }
//     return logList;
//   }

//   // @override
//   // deleteLogs(int logId) async {
//   //   var box = await Hive.openBox(kQuoteBox);

//   //   await box.deleteAt(logId);
//   //   // await box.delete(logId);
//   // }

//   close() => Hive.close();
// }
