import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonBackground.dart';
import 'package:todo_tracker_app/common/CommonScaffold.dart';
import 'package:todo_tracker_app/page/ConfirmNewPasswordPage.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/password/PasswordContainer.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  List<String> passwordList = [];

  onPressed(String text) {
    setState(() {
      if (text == '지우기') {
        if (passwordList.isNotEmpty) passwordList.removeLast();
      } else {
        if (passwordList.length < 4) passwordList.add(text);
        if (passwordList.length == 4) {
          movePage(
            context: context,
            page: ConfirmNewPasswordPage(passwordList: passwordList),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: ''),
        leading: IconButton(
          onPressed: () => navigatorPop(context),
          icon: const Icon(Icons.close_rounded),
        ),
        body: PasswordContainer(
          title: '새 비밀번호를 입력해주세요',
          passwordList: passwordList,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
