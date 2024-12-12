import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/body/record/recordContainer/RecordContainerItem.dart';
import 'package:todo_tracker_app/body/record/recordContainer/RecordContainerTitle.dart';
import 'package:todo_tracker_app/body/record/recordContainer/item/RecordItemEmpty.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/provider/GroupInfoListProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/func.dart';

class RecordContainer extends StatelessWidget {
  RecordContainer({super.key});

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().selectedDateTime;
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    List<GroupInfoClass> groupInfoList =
        context.watch<GroupInfoListProvider>().groupInfoList;

    List<TaskOrderClass> taskOrderList = userInfo.taskOrderList;
    List<RecordItemClass> recordItemList = getRecordItemList(
      locale: locale,
      targetDateTime: selectedDateTime,
      groupInfoList: groupInfoList,
      taskOrderList: taskOrderList,
    );

    onReorder(int oldIndex, int newIndex) async {
      int selectedDateTimeKey = dateTimeKey(selectedDateTime);
      List<String> taskInfoIdList =
          recordItemList.map((recordItem) => recordItem.taskInfo.tid).toList();

      if (oldIndex < newIndex) newIndex -= 1;

      String id = taskInfoIdList.removeAt(oldIndex);
      taskInfoIdList.insert(newIndex, id);

      TaskOrderClass newTaskOrder = TaskOrderClass(
        dateTimeKey: selectedDateTimeKey,
        list: taskInfoIdList,
      );

      if (taskOrderList.isEmpty) {
        taskOrderList.add(newTaskOrder);
      } else {
        int index = taskOrderList.indexWhere(
          (taskOrder) => taskOrder.dateTimeKey == selectedDateTimeKey,
        );

        index == -1
            ? taskOrderList.add(newTaskOrder)
            : taskOrderList[index].list = taskInfoIdList;
      }

      await userMethod.updateUser(userInfo: userInfo);
    }

    return CommonContainer(
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          RecordContainerTitle(),
          recordItemList.isNotEmpty
              ? ReorderableListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: recordItemList.length,
                  onReorder: onReorder,
                  itemBuilder: (context, index) {
                    RecordItemClass recordItem = recordItemList[index];
                    Key key = Key(recordItem.taskInfo.tid);

                    return RecordContainerItem(
                      key: key,
                      recordItem: recordItem,
                    );
                  },
                )
              : const RecordItemEmpty(),
        ],
      ),
    );
  }
}
