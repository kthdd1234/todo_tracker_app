import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/body/setting/SettingAppbar.dart';
import 'package:todo_tracker_app/body/setting/SettingSvg.dart';
import 'package:todo_tracker_app/body/setting/SettingTitle.dart';
import 'package:todo_tracker_app/body/setting/SettingValue.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/page/BackgroundPage.dart';
import 'package:todo_tracker_app/page/FontPage.dart';
import 'package:todo_tracker_app/page/NewPasswordPage.dart';
import 'package:todo_tracker_app/page/ProfilePage.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/PremiumProvider.dart';
import 'package:todo_tracker_app/provider/ReloadProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/bottomSheet/LanguageModalSheet.dart';
import 'package:todo_tracker_app/widget/bottomSheet/PremiumBottomSheet.dart';
import 'package:todo_tracker_app/widget/bottomSheet/ThemeBottomSheet.dart';
import 'package:todo_tracker_app/widget/popup/AlertPopup.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingBody extends StatefulWidget {
  const SettingBody({super.key});

  @override
  State<SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody> {
  String appVerstion = '';
  String appBuildNumber = '';

  @override
  void initState() {
    getInfo() async {
      Map<String, dynamic> appInfo = await getAppInfo();

      appVerstion = appInfo['appVerstion'];
      appBuildNumber = appInfo['appBuildNumber'];

      setState(() {});
    }

    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ReloadProvider>().isReload;
    String locale = context.locale.toString();

    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    bool isPremium = context.watch<PremiumProvider>().isPremium;

    String theme = userInfo.theme;
    String fontFamily = userInfo.fontFamily;
    String loginType = userInfo.loginType;
    String background = userInfo.background;
    String? passwords = userInfo.passwords;

    onPremium() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => const PremiumBottomSheet(),
      );
    }

    onUser() {
      movePage(context: context, page: const ProfilePage());
    }

    onTheme() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => const ThemeBottomSheet(),
      );
    }

    onLock() {
      if (passwords != null) {
        showDialog(
          context: context,
          builder: (context) => AlertPopup(
            desc: '잠금을 해제할까요?',
            buttonText: '잠금 해제',
            isCancel: true,
            height: 158,
            onTap: () async {
              userInfo.passwords = null;
              await userMethod.updateUser(userInfo: userInfo);

              navigatorPop(context);
            },
          ),
        );
      } else {
        moveFadePage(context: context, page: const NewPasswordPage());
      }
    }

    onBackground() {
      movePage(context: context, page: const BackgroundPage());
    }

    onFont() {
      movePage(context: context, page: const FontPage());
    }

    onLanguage() async {
      await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => const LanguageModalSheet(),
      );
    }

    onInquire() {
      String body =
          '========투두 트래커(${Platform.isIOS ? "IOS" : "Android"})========';
      FlutterEmailSender.send(Email(
        body: body,
        subject: '[개발자 문의]',
        recipients: ['kthdd1234@gmail.com'],
        cc: [],
        bcc: [],
        attachmentPaths: [],
        isHTML: false,
      ))
          .then(
        (value) => showSnackBar(
          context: context,
          text: '문의 해주셔서 감사합니다.',
          buttonName: '확인',
          width: 280,
        ),
      )
          .catchError(
        (error) {
          String message =
              "기본 메일 앱을 사용할 수 없기 때문에 앱에서\n바로 문의를 전송하기 어려운 상황입니다.\n\n아래 이메일로 연락주시면\n친절하게 답변해드릴게요 :)\n\nkthdd1234@gmail.com"
                  .tr();

          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              content: Text(message),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text("확인").tr(),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        },
      );
    }

    onPrivate() async {
      Uri url = Uri(
        scheme: 'https',
        host: 'nettle-dill-e85.notion.site',
        path: '159e257ae282806ba1bde7b0c78480e2',
        queryParameters: {'pvs': '4'},
      );

      await canLaunchUrl(url) ? await launchUrl(url) : throw 'launchUrl error';
    }

    onVersion() async {
      // Uri url = Platform.isIOS
      //     ? Uri(
      //         scheme: 'https',
      //         host: 'apps.apple.com',
      //         path: 'ko/app/easy-money-household-ledger/id6737747809',
      //       )
      //     : Uri(
      //         scheme: 'https',
      //         host: 'play.google.com',
      //         path:
      //             'store/apps/details?id=com.kthdd.household_account_book_app',
      //       );

      // await canLaunchUrl(url) ? await launchUrl(url) : print('err');
    }

    List<SettingItemClass> settingItemList = [
      SettingItemClass(
        name: '광고 제거 + 사진 추가',
        svg: 'crown',
        onTap: onPremium,
        value: isPremium ? '구매 완료' : '미구매',
      ),
      SettingItemClass(
        name: '프로필',
        svg: 'user',
        value: authButtonInfo[loginType]!['name'],
        onTap: onUser,
      ),
      SettingItemClass(
        name: '테마',
        svg: 'mode',
        value: theme == 'light' ? '밝은 테마' : '어두운 테마',
        onTap: onTheme,
      ),
      SettingItemClass(
        name: '잠금',
        svg: 'lock',
        value: passwords == null ? '없음' : '잠금 중',
        onTap: onLock,
      ),
      SettingItemClass(
        name: '배경',
        svg: 'background',
        value: backroundClassList
            .expand((list) => list)
            .toList()
            .firstWhere((item) => item.path == background)
            .name,
        onTap: onBackground,
      ),
      SettingItemClass(
        name: '글꼴',
        svg: 'font',
        value: getFontName(fontFamily),
        onTap: onFont,
      ),
      SettingItemClass(
        name: '언어',
        svg: 'language',
        value: getLocaleName(locale),
        onTap: onLanguage,
      ),
      SettingItemClass(
        name: '개발자 문의',
        svg: 'inquire',
        onTap: onInquire,
      ),
      SettingItemClass(
        name: '개인정보처리방침',
        svg: 'private',
        onTap: onPrivate,
      ),
      SettingItemClass(
        name: '앱 버전',
        svg: 'version',
        value: '$appVerstion ($appBuildNumber)',
        onTap: onVersion,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingAppBar(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: settingItemList
                  .map(
                    (settingItem) => InkWell(
                      onTap: settingItem.onTap,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.5),
                        child: Row(
                          children: [
                            SettingSvg(svg: settingItem.svg),
                            SettingTitle(title: settingItem.name),
                            const Spacer(),
                            SettingValue(
                              text: settingItem.value,
                              isVersion: settingItem.name == '앱 버전',
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        )
      ],
    );
  }
}
