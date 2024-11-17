// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// // import 'package:purchases_flutter/purchases_flutter.dart';
// import 'package:todo_tracker_app/common/CommonCloseButton.dart';
// import 'package:todo_tracker_app/common/CommonContainer.dart';
// import 'package:todo_tracker_app/common/CommonImageButton.dart';
// import 'package:todo_tracker_app/common/CommonModalSheet.dart';
// import 'package:todo_tracker_app/common/CommonSpace.dart';
// import 'package:todo_tracker_app/common/CommonSvgText.dart';
// import 'package:todo_tracker_app/common/CommonText.dart';
// import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
// import 'package:todo_tracker_app/provider/PremiumProvider.dart';
// import 'package:todo_tracker_app/provider/ThemeProvider.dart';
// import 'package:todo_tracker_app/util/constants.dart';
// import 'package:todo_tracker_app/util/enum.dart';
// import 'package:todo_tracker_app/util/final.dart';
// import 'package:todo_tracker_app/util/func.dart';
// import 'package:todo_tracker_app/widget/popup/LoadingPopup.dart';

// class PremiumBottomSheet extends StatefulWidget {
//   const PremiumBottomSheet({super.key});

//   @override
//   State<PremiumBottomSheet> createState() => _PremiumBottomSheetState();
// }

// class _PremiumBottomSheetState extends State<PremiumBottomSheet> {
//   Package? package;

//   @override
//   void initState() {
//     initIAP() async {
//       try {
//         Offerings offerings = await Purchases.getOfferings();
//         List<Package>? availablePackages =
//             offerings.getOffering(offeringIdentifier)?.availablePackages;

//         if (availablePackages != null && availablePackages.isNotEmpty) {
//           setState(() => package = availablePackages[0]);
//         }
//       } on PlatformException catch (e) {
//         log('PlatformException =>> $e');
//       }
//     }

//     initIAP();
//     super.initState();
//   }

//   onPurchase() async {
//     if (package != null) {
//       try {
//         showDialog(
//           context: context,
//           builder: (context) => LoadingPopup(
//             text: '데이터 불러오는 중...',
//             color: Colors.white,
//           ),
//         );

//         bool isPurchaseResult = await setPurchasePremium(package!);
//         context.read<PremiumProvider>().setPremiumValue(isPurchaseResult);
//       } on PlatformException catch (e) {
//         PurchasesErrorCode errorCode = PurchasesErrorHelper.getErrorCode(e);

//         if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
//           log('errorCode =>> $errorCode');
//         }
//       } finally {
//         navigatorPop(context);
//       }
//     }
//   }

//   onRestore() async {
//     bool isRestorePremium = await isPurchaseRestore();
//     context.read<PremiumProvider>().setPremiumValue(isRestorePremium);
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isPremium = context.watch<PremiumProvider>().isPremium;
//     bool isLight = context.watch<ThemeProvider>().isLight;
//     double fontSize = context.watch<FontSizeProvider>().fintSize;

//     return CommonModalSheet(
//       title: '광고 제거',
//       actionButton: const ModalCloseButton(),
//       height: 500,
//       child: Column(
//         children: [
//           Expanded(
//             child: CommonContainer(
//               outerPadding: EdgeInsets.only(bottom: 15),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   svgAsset(name: 'premium-no-ads', width: 100),
//                   CommonSpace(height: 20),
//                   CommonText(text: '앱 내의 전면 광고가 제거 됩니다.'),
//                   CommonText(text: '커피 한잔의 가격으로'),
//                   CommonText(text: '광고 없이 쾌적하게 이용해보세요!')
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 10),
//             child: CommonText(
//               text: '구매 내역 복원하기',
//               color: isLight ? grey.original : grey.s200,
//               decoration: TextDecoration.underline,
//               decorationColor: isLight ? grey.s400 : grey.s100,
//               onTap: onRestore,
//             ),
//           ),
//           isPremium
//               ? Padding(
//                   padding: const EdgeInsets.only(bottom: 5),
//                   child: CommonSvgText(
//                     text: '구매가 완료되었어요 :D',
//                     initFontSize: fontSize,
//                     isBold: !isLight,
//                     svgName: 'premium-badge',
//                     svgWidth: fontSize + 2,
//                     svgDirection: SvgDirectionEnum.left,
//                     isCenter: true,
//                   ),
//                 )
//               : Padding(
//                   padding: const EdgeInsets.only(bottom: 5),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: CommonImageButton(
//                       path: 'remove-ads',
//                       text: '구매하기',
//                       isBold: true,
//                       nameArgs: {
//                         "price": package?.storeProduct.priceString ?? 'None'
//                       },
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       onTap: onPurchase,
//                     ),
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
// }
