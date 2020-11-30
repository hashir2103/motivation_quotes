import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';

class AdMobServices {
  var rewardedVideoAd = RewardedVideoAd.instance;
  static String getAdMobAppID() {
    if (Platform.isIOS) {
      return "ca-app-pub-1059342231343027~5276715551"; //realid
      // return "ca-app-pub-3940256099942544/5662855259";
    } else if (Platform.isAndroid) {
      // return "ca-app-pub-1059342231343027~2820914933"; //realid
      return "ca-app-pub-3940256099942544/3419835294";
    }
    return null;
  }

  String getInterstitialAdID() {
    if (Platform.isIOS) {
      // return "ca-app-pub-1059342231343027/8488190492"; //realId
      return "ca-app-pub-3940256099942544/4411468910"; //testId
    } else if (Platform.isAndroid) {
      // return "ca-app-pub-1059342231343027/9992843854"; //realId
      return "ca-app-pub-3940256099942544/1033173712"; //testId
    }
    return null;
  }

  String getRewardAdID() {
    if (Platform.isIOS) {
      // return "ca-app-pub-1059342231343027/1379856667"; //realId
      return "ca-app-pub-3940256099942544/1712485313"; //testId
    } else if (Platform.isAndroid) {
      // return "ca-app-pub-1059342231343027/8416038302"; //realId
      return "ca-app-pub-3940256099942544/5224354917"; //testId
    }
    return null;
  }

  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  loadRewardAd() {
    rewardedVideoAd.load(adUnitId: getRewardAdID(), targetingInfo: targetingInfo);
  }

  showRewardedAds() {
    rewardedVideoAd.show();
  }

  InterstitialAd getNewCategoryInterstitial() {
    return InterstitialAd(
      adUnitId: getInterstitialAdID(),
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
  }
}
