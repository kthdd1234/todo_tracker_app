import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:todo_tracker_app/util/func.dart';

class InterstitialAdService {
  InterstitialAd? _interstitialAd;

  String adUnitId = getAdId('interstitial');

  void loadAd() async {
    // bool isPremium = await isPurchasePremium();
    bool isPremium = true;

    if (isPremium == false) {
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
                loadAd();
              },
            );

            _interstitialAd = ad;
            showLog();
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ),
      );
    }
  }

  void showAd() async {
    if (_interstitialAd != null) {
      await _interstitialAd!.show();
    }
  }

  void showLog() {
    log('전면 광고 로드 체크 => $_interstitialAd');
  }
}
