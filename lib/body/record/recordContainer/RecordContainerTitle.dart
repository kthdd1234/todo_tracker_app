import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonDivider.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonTag.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/GroupInfoListProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/bottomSheet/TitleSettingModalSheet.dart';

class RecordContainerTitle extends StatefulWidget {
  RecordContainerTitle({super.key});

  @override
  State<RecordContainerTitle> createState() => _RecordContainerTitleState();
}

class _RecordContainerTitleState extends State<RecordContainerTitle> {
  onTitle(UserInfoClass userInfo) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TitleBottomSheet(userInfo: userInfo),
    );
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();

    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    bool isLight = context.watch<ThemeProvider>().isLight;
    double fontSize = context.watch<FontSizeProvider>().fintSize;
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().selectedDateTime;
    List<GroupInfoClass> groupInfoList =
        context.watch<GroupInfoListProvider>().groupInfoList;

    String title = userInfo.titleInfo.title;
    ColorClass color = getColorClass(userInfo.titleInfo.colorName);
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

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CommonTag(
              text: title,
              isNotTr: true,
              isBold: !isLight,
              textColor: isLight ? color.original : color.s200,
              bgColor: isLight ? color.s50.withOpacity(0.5) : darkButtonColor,
              onTap: () => onTitle(userInfo),
            ),
            const Spacer(),
            CommonText(
              text: '${recordMarkList.length}/${recordItemList.length}',
              color: Colors.grey,
              initFontSize: fontSize - 2,
            ),
            CommonSpace(width: 3),
          ],
        ),
        CommonSpace(height: 10),
        CommonDivider(),
      ],
    );
  }
}
