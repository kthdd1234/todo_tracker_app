import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/widget/password/PasswordList.dart';
import 'package:todo_tracker_app/widget/password/PasswordNumberPad.dart';

class PasswordContainer extends StatelessWidget {
  PasswordContainer({
    super.key,
    required this.title,
    required this.passwordList,
    required this.onPressed,
    this.isConfirmMsg,
  });

  String title;
  List<String> passwordList;
  bool? isConfirmMsg;
  Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    double fontSize = userInfo.fontSize;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonText(text: title, initFontSize: fontSize + 2),
        CommonSpace(height: 15),
        PasswordList(isLight: isLight, passwordList: passwordList),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: CommonText(
            text: isConfirmMsg == true ? '비밀번호가 일치하지 않아요' : '',
            initFontSize: fontSize - 1,
            color: red.s400,
          ),
        ),
        CommonSpace(height: 45),
        PasswordNumberPad(onPressed: onPressed)
      ],
    );
  }
}
