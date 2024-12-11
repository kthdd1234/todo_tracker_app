import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonBackground.dart';
import 'package:todo_tracker_app/common/CommonScaffold.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/page/HomePage.dart';
import 'package:todo_tracker_app/page/NewPasswordPage.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/password/PasswordContainer.dart';

class EnterPasswordPage extends StatefulWidget {
  EnterPasswordPage({super.key});

  @override
  State<EnterPasswordPage> createState() => _EnterPasswordPageState();
}

class _EnterPasswordPageState extends State<EnterPasswordPage> {
  String passwords = '';
  List<String> enterPasswordList = [];
  bool isConfirmMsg = false;

  setData() async {
    UserInfoClass? userInfo = await userMethod.getUserInfo;

    if (userInfo != null) {
      setState(() {
        passwords = userInfo.passwords ?? '';
      });

      if (mounted) {
        context.read<UserInfoProvider>().changeUserInfo(newuUserInfo: userInfo);
        context.read<FontSizeProvider>().setFontSize(userInfo.fontSize);
        context.read<ThemeProvider>().setThemeValue(userInfo.theme);
      }
    }
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();

    onPressed(String text) {
      setState(() {
        if (text == '지우기') {
          if (enterPasswordList.isNotEmpty) enterPasswordList.removeLast();
        } else {
          if (enterPasswordList.length < 4) enterPasswordList.add(text);
        }
      });

      if (enterPasswordList.length == 4) {
        String enterPasswords = enterPasswordList.join('');

        if (passwords != enterPasswords) {
          setState(() {
            enterPasswordList = [];
            isConfirmMsg = true;
          });
        } else {
          navigatorRemoveUntil(
            context: context,
            page: HomePage(locale: locale),
          );
        }
      }
    }

    return CommonBackground(
      child: CommonScaffold(
        body: PasswordContainer(
          title: '비밀번호를 입력해주세요',
          isConfirmMsg: isConfirmMsg,
          passwordList: enterPasswordList,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
