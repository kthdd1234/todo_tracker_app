import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_tracker_app/common/CommonBackground.dart';
import 'package:todo_tracker_app/common/CommonScaffold.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/page/HomePage.dart';
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
  String background = '0';
  List<String> enterPasswordList = [];
  bool isConfirmMsg = false;

  setData() async {
    UserInfoClass? userInfo = await userMethod.getUserInfo;

    setState(() {
      passwords = userInfo?.passwords ?? '';
      background = userInfo?.background ?? '0';
    });
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
      background: background,
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
