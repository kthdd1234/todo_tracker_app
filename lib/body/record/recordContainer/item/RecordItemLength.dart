import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/GroupInfoListProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/func.dart';

class ReocrdItemLength extends StatelessWidget {
  const ReocrdItemLength({super.key});

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();

    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    double fontSize = context.watch<FontSizeProvider>().fintSize;
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().selectedDateTime;
    List<GroupInfoClass> groupInfoList =
        context.watch<GroupInfoListProvider>().groupInfoList;

    List<RecordItemClass> recordItemList = getRecordItemList(
      locale: locale,
      targetDateTime: selectedDateTime,
      groupInfoList: groupInfoList,
      taskOrderList: userInfo.taskOrderList,
    );
    List<RecordItemClass> recordMarkList = recordItemList.where((recordItem) {
      RecordInfoClass? recordInfo = getRecordInfo(
        recordInfoList: recordItem.taskInfo.recordInfoList,
        targetDateTime: selectedDateTime,
      );

      return recordInfo?.mark != null;
    }).toList();

    return Padding(
      padding: const EdgeInsets.only(right: 3),
      child: CommonText(
        text: '${recordMarkList.length}/${recordItemList.length}',
        color: Colors.grey,
        initFontSize: fontSize - 2,
        isNotTr: true,
      ),
    );
  }
}
