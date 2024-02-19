import 'dart:developer';

import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

abstract class AppodealFunc {
  static Future<void> initAppodeal() async {
    Appodeal.initialize(
        appKey: "69e67d0b49794e83f24fe5f3d779cc4b80e3ae67f5f2bdf9",
        adTypes: [
          AppodealAdType.Interstitial,
          AppodealAdType.RewardedVideo,
          AppodealAdType.Banner,
        ],
        onInitializationFinished: (errors) => {log(errors.toString())});
  }

  static void someMehodsBeforeInit() {
    Appodeal.setTesting(true);
    Appodeal.setLogLevel(Appodeal.LogLevelVerbose);
    Appodeal.setChildDirectedTreatment(false);
  }

  static void callbackInterstitialAd() {
    Appodeal.setInterstitialCallbacks(
        onInterstitialLoaded: (isPrecache) => {log('is Loaded')},
        onInterstitialFailedToLoad: () => {log('faild to Loaded')},
        onInterstitialShown: () => {log('is Shown')},
        onInterstitialShowFailed: () => {log('is Shown Faild')},
        onInterstitialClicked: () => {log('is Clicked')},
        onInterstitialClosed: () => {log('is Closed')},
        onInterstitialExpired: () => {log('is Expired')});
  }

  static Future<void> loadInterstitialAd() async {
    var isLoaded = await Appodeal.isLoaded(AppodealAdType.Interstitial);
    if (isLoaded) {
      var isCanShow = await Appodeal.canShow(AppodealAdType.Interstitial);
      if (isCanShow) {
        Appodeal.show(AppodealAdType.Interstitial);
      }
    } else {
      log('Faild To Load Ad');
    }
  }

  static void callbackRewardedAd({required Function onClosed}) {
    Appodeal.setRewardedVideoCallbacks(
        onRewardedVideoLoaded: (isPrecache) => {log('onRewardedVideoLoaded')},
        onRewardedVideoFailedToLoad: () => {log('RewardedVideo Faild Loaded')},
        onRewardedVideoShown: () => {log('RewardedVideo Shown')},
        onRewardedVideoShowFailed: () => {log('RewardedVideo Show Faild')},
        onRewardedVideoFinished: (amount, reward) => {
              log('RewardedVideo Finshed'),
              onClosed(),
            },
        onRewardedVideoClosed: (isFinished) => {log('RewardedVideo Closed')},
        onRewardedVideoExpired: () => {log('RewardedVideo Expired')},
        onRewardedVideoClicked: () => {log('RewardedVideo Clicked')});
  }

  static Future<void> loadRewardedAd({required Function onClosed}) async {
    var isLoaded = await Appodeal.isLoaded(AppodealAdType.RewardedVideo);
    if (isLoaded) {
      var isCanShow = await Appodeal.canShow(AppodealAdType.RewardedVideo);
      if (isCanShow) {
        Appodeal.show(AppodealAdType.RewardedVideo);
        callbackRewardedAd(onClosed: onClosed);
      }
    } else {
      log('Faild To Load Ad');
    }
  }

  static void callbackBanner() {
    Appodeal.setBannerCallbacks(
      onBannerLoaded: (isPrecache) => {log('Banner ad Loaded')},
      onBannerFailedToLoad: () => {log('Banner ad Faild Loaded')},
      onBannerShown: () => {log('Banner ad Shown')},
      onBannerShowFailed: () => {log('Banner ad Show Failed')},
      onBannerClicked: () => {log('Banner ad Clicked')},
      onBannerExpired: () => {log('Banner ad Expired')},
    );
  }

  static Future<void> loadBannerAd() async {
    var isLoaded = await Appodeal.isLoaded(Appodeal.BANNER);
    if (isLoaded) {
      var canShow = await Appodeal.canShow(Appodeal.BANNER);
      if (canShow) {
        callbackBanner();
        Appodeal.show(Appodeal.BANNER);
      }
    }
  }
}
