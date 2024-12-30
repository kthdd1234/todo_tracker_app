import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/GroupInfoListProvider.dart';
import 'package:todo_tracker_app/provider/PremiumProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/bottomSheet/TaskBottomSheet.dart';

class RecordItemEmpty extends StatelessWidget {
  const RecordItemEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    bool isPremium = context.watch<PremiumProvider>().isPremium;
    bool isLight = context.watch<ThemeProvider>().isLight;
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().selectedDateTime;
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    List<GroupInfoClass> groupInfoList =
        context.watch<GroupInfoListProvider>().groupInfoList;

    onAdd() {
      List<GroupInfoClass> groupInfoOrderList =
          getGroupInfoOrderList(userInfo.groupOrderList, groupInfoList);

      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => TaskBottomSheet(
          isPremium: isPremium,
          userInfo: userInfo,
          selectedDateTime: selectedDateTime,
          groupInfo: groupInfoOrderList[0],
        ),
      );
    }

    return InkWell(
      onTap: onAdd,
      child: SizedBox(
        height: 150,
        child: Center(
          child: CommonText(
            text: '+ 할 일 추가하기',
            color: isLight ? Colors.grey : grey.s300,
          ),
        ),
      ),
    );
  }
}
