import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonButton.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonImageButton.dart';
import 'package:todo_tracker_app/common/CommonModalSheet.dart';
import 'package:todo_tracker_app/page/GroupPage.dart';
import 'package:todo_tracker_app/provider/GroupInfoListProvider.dart';
import 'package:todo_tracker_app/provider/ReloadProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/button/GroupButton.dart';

class GroupListBottomSheet extends StatelessWidget {
  GroupListBottomSheet({
    super.key,
    required this.selectedGroupInfo,
    required this.onSelection,
  });

  GroupInfoClass selectedGroupInfo;
  Function(GroupInfoClass) onSelection;

  @override
  Widget build(BuildContext context) {
    context.watch<ReloadProvider>().isReload;

    bool isLight = context.watch<ThemeProvider>().isLight;
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    List<GroupInfoClass> groupInfoList =
        context.watch<GroupInfoListProvider>().groupInfoList;

    groupInfoList = getGroupInfoOrderList(
      userInfo.groupOrderList,
      groupInfoList,
    );

    onManege() {
      movePage(context: context, page: GroupPage());
    }

    return CommonModalSheet(
      title: '그룹을 선택해주세요',
      height: 450,
      isBack: true,
      child: CommonContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: groupInfoList
                  .map(
                    (groupInfo) => GroupButton(
                      selectedGroupId: selectedGroupInfo.gid,
                      groupInfo: groupInfo,
                      onSelection: onSelection,
                    ),
                  )
                  .toList(),
            ),
            const Spacer(),
            CommonButton(
              text: '그룹 관리',
              isBold: true,
              textColor: Colors.white,
              buttonColor: isLight ? textColor : darkButtonColor,
              verticalPadding: 12.5,
              borderRadius: 7,
              onTap: onManege,
            )
          ],
        ),
      ),
    );
  }
}

      

            //  CommonImageButton(
            //   path: 'deep-blue',
            //   text: '그룹 관리',
            //   isBold: true,
            //   width: double.infinity,
            //   padding: const EdgeInsets.symmetric(vertical: 12.5),
            //   onTap: onManege,
            // )