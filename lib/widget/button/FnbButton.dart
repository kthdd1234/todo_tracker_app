import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/page/MemoPage.dart';
import 'package:todo_tracker_app/provider/GroupInfoListProvider.dart';
import 'package:todo_tracker_app/provider/MemoInfoListProvider.dart';
import 'package:todo_tracker_app/provider/PremiumProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/bottomSheet/TaskBottomSheet.dart';
import 'package:todo_tracker_app/widget/button/SpeedDialButton.dart';
import 'package:todo_tracker_app/widget/button/SpeedDialChildButton.dart';

class FnbButton extends StatefulWidget {
  FnbButton({super.key});

  @override
  State<FnbButton> createState() => _FnbButtonState();
}

class _FnbButtonState extends State<FnbButton> {
  @override
  Widget build(BuildContext context) {
    bool isPremium = context.watch<PremiumProvider>().isPremium;
    bool isLight = context.watch<ThemeProvider>().isLight;
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().selectedDateTime;
    List<GroupInfoClass> groupInfoList =
        context.watch<GroupInfoListProvider>().groupInfoList;
    List<MemoInfoClass> memoInfoList =
        context.watch<MemoInfoListProvider>().memoInfoList;

    onAddTodo() {
      List<GroupInfoClass> groupInfoOrderList =
          getGroupInfoOrderList(userInfo.groupOrderList, groupInfoList);

      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => TaskBottomSheet(
          groupInfo: groupInfoOrderList[0],
          selectedDateTime: selectedDateTime,
        ),
      );
    }

    onAddMemo() {
      int index = memoInfoList.indexWhere(
        (memoInfo) => memoInfo.dateTimeKey == dateTimeKey(selectedDateTime),
      );
      MemoInfoClass? memoInfo = index != -1 ? memoInfoList[index] : null;

      movePage(
        context: context,
        page: MemoPage(
          isPremium: isPremium,
          initDateTime: selectedDateTime,
          memoInfoList: memoInfoList,
          memoInfo: memoInfo,
        ),
      );
    }

    return SpeedDialButton(
      icon: Icons.add,
      activeBackgroundColor: isLight ? red.s200 : darkButtonColor,
      backgroundColor: isLight ? indigo.s300 : darkButtonColor,
      children: [
        speedDialChildButton(
          isLight: isLight,
          svg: 'plus',
          lable: '할 일 추가',
          color: blue,
          onTap: onAddTodo,
        ),
        speedDialChildButton(
          isLight: isLight,
          svg: 'pencil',
          lable: '메모 추가',
          color: orange,
          onTap: onAddMemo,
        ),
      ],
    );
  }
}
