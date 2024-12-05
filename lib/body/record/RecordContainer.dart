import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/body/record/widget/RecordContainerItem.dart';
import 'package:todo_tracker_app/body/record/widget/RecordContainerTitle.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/provider/GroupInfoListProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/bottomSheet/GroupListBottomSheet.dart';

class RecordContainer extends StatelessWidget {
  const RecordContainer({super.key});

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    DateTime seletedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    List<GroupInfoClass> groupInfoList =
        context.watch<GroupInfoListProvider>().groupInfoList;

    List<RecordItemClass> recordItemList = getTaskInfoList(
      locale: locale,
      targetDateTime: seletedDateTime,
      groupInfoList: groupInfoList,
      taskOrderList: userInfo.taskOrderList,
    );

    return CommonContainer(
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          RecordContainerTitle(),
          Column(
            children: recordItemList
                .map(
                    (recordItem) => RecordContainerItem(recordItem: recordItem))
                .toList(),
          ),
        ],
      ),
    );
  }
}
