import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:todo_tracker_app/common/CommonCloseButton.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonImageButton.dart';
import 'package:todo_tracker_app/common/CommonModalSheet.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonSvgText.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/PremiumProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/enum.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/popup/LoadingPopup.dart';

class PremiumBottomSheet extends StatefulWidget {
  const PremiumBottomSheet({super.key});

  @override
  State<PremiumBottomSheet> createState() => _PremiumBottomSheetState();
}

class _PremiumBottomSheetState extends State<PremiumBottomSheet> {
  Package? package;

  @override
  void initState() {
    initIAP() async {
      try {
        Offerings offerings = await Purchases.getOfferings();
        List<Package>? availablePackages =
            offerings.getOffering(offeringIdentifier)?.availablePackages;

        if (availablePackages != null && availablePackages.isNotEmpty) {
          setState(() => package = availablePackages[0]);
        }
      } on PlatformException catch (e) {
        log('PlatformException =>> $e');
      }
    }

    initIAP();
    super.initState();
  }

  onPurchase() async {
    if (package != null) {
      try {
        showDialog(
          context: context,
          builder: (context) => LoadingPopup(
            text: '데이터 불러오는 중...',
            color: Colors.white,
          ),
        );

        bool isPurchaseResult = await setPurchasePremium(package!);
        context.read<PremiumProvider>().setPremiumValue(isPurchaseResult);
      } on PlatformException catch (e) {
        PurchasesErrorCode errorCode = PurchasesErrorHelper.getErrorCode(e);

        if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
          log('errorCode =>> $errorCode');
        }
      } finally {
        navigatorPop(context);
      }
    }
  }

  onRestore() async {
    bool isRestorePremium = await isPurchaseRestore();
    context.read<PremiumProvider>().setPremiumValue(isRestorePremium);
  }

  @override
  Widget build(BuildContext context) {
    bool isPremium = context.watch<PremiumProvider>().isPremium;
    bool isLight = context.watch<ThemeProvider>().isLight;
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    return CommonModalSheet(
      title: '광고 제거 + 사진 추가',
      actionButton: const ModalCloseButton(),
      height: 455,
      child: Column(
        children: [
          PremiumItem(
            title: '단 한번 결제로 평생 이용할 수 있어요',
            subTitle: '구독 결제가 아닌 깔끔하게 단 한번 결제!',
            svg: 'premium-free',
          ),
          PremiumItem(
            title: '모든 화면에서 광고가 제거돼요',
            subTitle: '광고 없이 쾌적하게 앱을 이용해보세요!',
            svg: 'premium-no-ads',
          ),
          PremiumItem(
            title: '메모 할 때 사진도 추가할 수 있어요',
            subTitle: '메모 글 뿐만 아니라 사진도 함께 추가해보세요!',
            svg: 'premium-add-photo',
          ),
          CommonSpace(height: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CommonText(
              text: '구매 내역 복원하기',
              color: isLight ? grey.original : grey.s200,
              decoration: TextDecoration.underline,
              decorationColor: isLight ? grey.s400 : grey.s100,
              onTap: onRestore,
            ),
          ),
          isPremium
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: CommonSvgText(
                    text: '구매가 완료되었어요 :D',
                    initFontSize: fontSize,
                    isBold: !isLight,
                    svgName: 'premium-badge',
                    svgWidth: fontSize + 2,
                    svgDirection: SvgDirectionEnum.left,
                    isCenter: true,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                    width: double.infinity,
                    child: CommonImageButton(
                      path: 'deep-red',
                      text: '구매하기',
                      isBold: true,
                      nameArgs: {
                        "price": package?.storeProduct.priceString ?? 'None'
                      },
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      onTap: onPurchase,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

// svgAsset(name: 'premium-no-ads', width: 100),
// CommonSpace(height: 20),
// CommonText(text: '단 한 번의 결제로 사진을 추가하고'),
// CommonText(text: '평생 광고 없이 앱을 이용해보세요.')

class PremiumItem extends StatelessWidget {
  PremiumItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.svg,
  });

  String title, subTitle, svg;

  @override
  Widget build(BuildContext context) {
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CommonContainer(
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(text: title),
                    CommonSpace(height: 1),
                    CommonText(
                      text: subTitle,
                      initFontSize: fontSize - 2,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            CommonSpace(width: 20),
            svgAsset(name: svg, width: 45),
          ],
        ),
      ),
    );
  }
}
