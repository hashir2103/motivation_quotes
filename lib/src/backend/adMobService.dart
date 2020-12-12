// import 'dart:io';
// // import 'package:firebase_admob/firebase_admob.dart';

// class AdMobServices {
//   // var rewardedVideoAd = RewardedVideoAd.instance;
//   static String getAdMobAppID() {
//     if (Platform.isIOS) {
//       return "ca-app-pub-1113274221551554~6621548826"; //realid
//       // return "ca-app-pub-3940256099942544/motivation_quotes5662855259";
//     } else if (Platform.isAndroid) {
//       return "ca-app-pub-1113274221551554~1843014802"; //realid
//       // return "ca-app-pub-3940256099942544/3419835294";
//     }
//     return null;
//   }

//   String getInterstitialAdID() {
//     if (Platform.isIOS) {
//       return "ca-app-pub-1113274221551554/4288041282"; //realId
//       // return "ca-app-pub-3940256099942544/4411468910"; //testId
//     } else if (Platform.isAndroid) {
//       return "ca-app-pub-1113274221551554/4599032471"; //realId
//       // return "ca-app-pub-3940256099942544/1033173712"; //testId
//     }
//     return null;
//   }

//   String getRewardAdID() {
//     if (Platform.isIOS) {
//       return "ca-app-pub-1113274221551554/9659787465"; //realId
//       // return "ca-app-pub-3940256099942544/1712485313"; //testId
//     } else if (Platform.isAndroid) {
//       return "ca-app-pub-1113274221551554/1853449631"; //realId
//       // return "ca-app-pub-3940256099942544/5224354917"; //testId
//     }
//     return null;
//   }

//   // MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//   //   keywords: <String>['flutterio', 'beautiful apps'],
//   //   contentUrl: 'https://flutter.io',
//   //   childDirected: true,
//   //   nonPersonalizedAds: true,
//   //   testDevices: <String>[], // Android emulators are considered test devices
//   // );

//   // loadRewardAd() {
//   //   rewardedVideoAd.load(
//   //       adUnitId: getRewardAdID(), targetingInfo: targetingInfo).catchError((e){
//   //         print('error ====== $e');
//   //       });
//   // }

//   // showRewardedAds() {
//   //   rewardedVideoAd.show().catchError((e) {
//   //     print('error ====== $e');
//   //   });
//   // }

//   InterstitialAd getNewCategoryInterstitial() {
//     return InterstitialAd(
//       adUnitId: getInterstitialAdID(),
//       targetingInfo: targetingInfo,
//       listener: (MobileAdEvent event) {
//         if (event == MobileAdEvent.failedToLoad) {
//           print('==================>Failed To load Ads');
//           InterstitialAd().load();
//         } else if (event == MobileAdEvent.closed) {
//           print('==================>Ad Closed');
//           InterstitialAd().load();
//         }
//       },
//     );
//   }
// }
