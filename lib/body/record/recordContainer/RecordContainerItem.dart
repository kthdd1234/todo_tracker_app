import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/body/record/recordContainer/item/RecordItemBar.dart';
import 'package:todo_tracker_app/body/record/recordContainer/item/RecordItemMemo.dart';
import 'package:todo_tracker_app/body/record/recordContainer/item/RecordItemName.dart';
import 'package:todo_tracker_app/body/record/recordContainer/item/RecordItemMarker.dart';
import 'package:todo_tracker_app/common/CommonDivider.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/bottomSheet/TaskInfoBottomSheet.dart';
import 'package:todo_tracker_app/widget/popup/MarkPopup.dart';

class RecordContainerItem extends StatelessWidget {
  RecordContainerItem({super.key, required this.recordItem});

  RecordItemClass recordItem;

  @override
  Widget build(BuildContext context) {
    double fontSize = context.watch<FontSizeProvider>().fintSize;
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().selectedDateTime;

    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    GroupInfoClass groupInfo = recordItem.groupInfo;
    TaskInfoClass taskInfo = recordItem.taskInfo;
    ColorClass color = getColorClass(groupInfo.colorName);
    RecordInfoClass? recordInfo = getRecordInfo(
      recordInfoList: taskInfo.recordInfoList,
      targetDateTime: selectedDateTime,
    );
    String? mark = recordInfo?.mark;

    onInfo() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => TaskInfoBottomSheet(
          userInfo: userInfo,
          groupInfo: groupInfo,
          taskInfo: taskInfo,
          initDateTime: selectedDateTime,
        ),
      );
    }

    onMark() {
      showDialog(
        context: context,
        builder: (context) => MarkPopup(
          fontSize: fontSize,
          groupInfo: groupInfo,
          taskInfo: taskInfo,
          selectedDateTime: selectedDateTime,
        ),
      );
    }

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: onInfo,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: [
                        RecordItemBar(color: color),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RecordItemName(
                                name: taskInfo.name,
                                color: color,
                                mark: mark,
                              ),
                              RecordItemMemo(memo: recordInfo?.memo),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              RecordItemMaker(mark: mark, color: color, onTap: onMark),
            ],
          ),
        ),
        CommonDivider()
      ],
    );
  }
}
