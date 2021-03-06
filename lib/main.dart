
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:motivation_quotes/src/backend/adMobService.dart';
import 'App.dart';
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance.initialize(appId: AdMobServices.getAdMobAppID());
  runApp(MyApp());
}