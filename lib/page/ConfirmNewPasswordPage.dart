import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonBackground.dart';
import 'package:todo_tracker_app/common/CommonScaffold.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/page/HomePage.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/password/PasswordContainer.dart';

class ConfirmNewPasswordPage extends StatefulWidget {
  ConfirmNewPasswordPage({super.key, required this.passwordList});

  List<String> passwordList;

  @override
  State<ConfirmNewPasswordPage> createState() => _ConfirmNewPasswordPageState();
}

class _ConfirmNewPasswordPageState extends State<ConfirmNewPasswordPage> {
  List<String> comfirmPasswordList = [];
  bool isConfirmMsg = false;

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;

    onPressed(String text) async {
      setState(() {
        if (text == '지우기') {
          if (comfirmPasswordList.isNotEmpty) comfirmPasswordList.removeLast();
        } else {
          if (comfirmPasswordList.length < 4) comfirmPasswordList.add(text);
        }
      });

      if (comfirmPasswordList.length == 4) {
        String passwords = widget.passwordList.join('');
        String confirmPasswords = comfirmPasswordList.join('');

        if (passwords != confirmPasswords) {
          setState(() {
            comfirmPasswordList = [];
            isConfirmMsg = true;
          });
        } else {
          userInfo.passwords = passwords;
          await userMethod.updateUser(userInfo: userInfo);

          navigatorRemoveUntil(
            context: context,
            page: HomePage(locale: locale),
          );
        }
      }
    }

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: ''),
        body: PasswordContainer(
          title: '방금 입력한 비밀번호를\n한번 더 입력해주세요',
          passwordList: comfirmPasswordList,
          isConfirmMsg: isConfirmMsg,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
