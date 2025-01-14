import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonBackground.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonScaffold.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonSvgText.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/page/IntroPage.dart';
import 'package:todo_tracker_app/provider/MemoInfoListProvider.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/GroupInfoListProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/enum.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/popup/AlertPopup.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;

  button({
    required String title,
    required Color color,
    required Widget child,
    required bool isBold,
    required Function() onTap,
  }) {
    return CommonContainer(
      onTap: onTap,
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        CommonText(text: title, color: color, isBold: isBold),
        const Spacer(),
        child
      ]),
    );
  }

  loading() {
    return CommonContainer(
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 11,
            height: 11,
            child: CircularProgressIndicator(
              strokeWidth: 1,
              color: red.original,
            ),
          ),
          CommonSpace(width: 7),
          CommonText(text: '회원 탈퇴 중...', color: red.s400)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    List<GroupInfoClass> groupInfoList =
        context.watch<GroupInfoListProvider>().groupInfoList;
    List<MemoInfoClass> memoInfoList =
        context.watch<MemoInfoListProvider>().memoInfoList;
    bool isLight = context.watch<ThemeProvider>().isLight;
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    String loginType = userInfo.loginType;
    String loginText = authButtonInfo[loginType]!['name'];
    String svg = authButtonInfo[loginType]!['svg'];

    onSignOut() async {
      await auth.signOut();
      navigatorRemoveUntil(context: context, page: const IntroPage());
    }

    onLogout() {
      try {
        if (loginType == 'guest') {
          showDialog(
            context: context,
            builder: (context) => AlertPopup(
              height: 220,
              desc: '게스트 계정은 로그아웃 시\n이전에 기록한 데이터를 모두 삭제합니다.\n그래도 진행하시겠습니까?',
              alert: '(광고 제거 + 사진 추가 구매 내역은 그대로 유지됩니다)',
              buttonText: '확인',
              isCancel: true,
              onTap: () => onSignOut(),
            ),
          );
        } else {
          onSignOut();
        }
      } catch (e) {
        return null;
      }
    }

    onLeave() async {
      navigatorPop(context);
      setState(() => isLoading = true);

      try {
        await userMethod.deleteUser(
          context,
          userInfo.loginType,
          groupInfoList,
          memoInfoList,
        );

        setState(() => isLoading = false);
      } catch (e) {
        log('$e');
        return null;
      }
    }

    onDeletePopup() async {
      showDialog(
        context: context,
        builder: (context) => AlertPopup(
          desc: '정말 회원 탈퇴할까요?',
          isCancel: true,
          buttonText: '탈퇴하기',
          height: 155,
          onTap: onLeave,
        ),
      );
    }

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '프로필'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              button(
                title: '로그인 연동',
                color: isLight ? Colors.black : Colors.white,
                isBold: !isLight,
                child: CommonSvgText(
                  text: loginText,
                  initFontSize: fontSize - 1, // 14
                  isBold: !isLight,
                  svgWidth: fontSize - 2, // 12
                  textColor: isLight ? Colors.black : Colors.white,
                  svgName: svg,
                  svgDirection: SvgDirectionEnum.left,
                  svgColor: svg == 'apple-logo' ? Colors.white : null,
                ),
                onTap: () {},
              ),
              button(
                title: '로그아웃',
                isBold: !isLight,
                color: red.s400,
                child: svgAsset(
                  name: 'dir-right',
                  width: 7,
                  color: red.original,
                ),
                onTap: onLogout,
              ),
              isLoading
                  ? loading()
                  : button(
                      isBold: !isLight,
                      title: '회원 탈퇴',
                      color: red.s400,
                      child: svgAsset(
                        name: 'dir-right',
                        width: 7,
                        color: red.original,
                      ),
                      onTap: onDeletePopup,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
