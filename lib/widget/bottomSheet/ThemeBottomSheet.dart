import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonModalButton.dart';
import 'package:todo_tracker_app/common/CommonModalSheet.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';

class ThemeBottomSheet extends StatelessWidget {
  ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    bool isLight = context.read<ThemeProvider>().isLight;

    button({required String id, required String name}) {
      bool isSelected = userInfo.theme == id;

      Color buttonTextColor = isLight
          ? isSelected
              ? Colors.white
              : grey.original
          : isSelected
              ? Colors.white
              : grey.s300;

      Color buttonBgColor = isLight
          ? isSelected
              ? textColor
              : Colors.white
          : isSelected
              ? textColor
              : darkContainerColor;

      return CommonModalButton(
        svgName: id,
        actionText: name,
        isBold: isSelected,
        color: buttonTextColor,
        bgColor: buttonBgColor,
        onTap: () async {
          userInfo.theme = id;

          context.read<ThemeProvider>().setThemeValue(id);
          await userMethod.updateUser(userInfo: userInfo);

          navigatorPop(context);
        },
      );
    }

    return CommonModalSheet(
      title: '테마',
      height: 190,
      child: Row(
        children: [
          button(id: 'light', name: '밝은 테마'),
          CommonSpace(width: 5),
          button(id: 'dark', name: '어두운 테마'),
        ],
      ),
    );
  }
}
