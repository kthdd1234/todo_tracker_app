import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/func.dart';

class InterstitialAdService {
  InterstitialAd? _interstitialAd;

  String adUnitId = getAdId('interstitial');

  void loadAd({
    required bool isPremium,
    required UserInfoClass userInfo,
  }) async {
    int nowKey = dateTimeKey(DateTime.now());
    int? adDateTimeKey = userInfo.adDateTimeKey;

    bool isNotPremium = isPremium == false;
    bool isDateTimeKey = (adDateTimeKey == null) || (nowKey != adDateTimeKey);

    log('loadAd: $nowKey, $adDateTimeKey');

    if (isNotPremium && isDateTimeKey) {
      InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
                _interstitialAd = null;
              },
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
                _interstitialAd = null;

                loadAd(isPremium: isPremium, userInfo: userInfo);
              },
            );

            _interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ),
      );
    }
  }

  void showAd({
    required bool isPremium,
    required UserInfoClass userInfo,
  }) async {
    int nowKey = dateTimeKey(DateTime.now());
    int? adDateTimeKey = userInfo.adDateTimeKey;

    bool isLoadAd = _interstitialAd != null;
    bool isNotPremium = isPremium == false;
    bool isDateTimeKey = (adDateTimeKey == null) || (nowKey != adDateTimeKey);

    log('showAd: $nowKey, $adDateTimeKey');

    if (isLoadAd && isNotPremium && isDateTimeKey) {
      await _interstitialAd!.show();

      userInfo.adDateTimeKey = nowKey;
      await userMethod.updateUser(userInfo: userInfo);
    }
  }
}
