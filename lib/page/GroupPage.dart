import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonBackground.dart';
import 'package:todo_tracker_app/common/CommonButton.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/common/CommonScaffold.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/bottomSheet/GroupInfoBottomSheet.dart';
import 'package:todo_tracker_app/widget/group/GroupEditButton.dart';
import 'package:todo_tracker_app/widget/group/GroupItemButton.dart';
import 'package:todo_tracker_app/widget/popup/AlertPopup.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    List<String> groupOrderList = userInfo.groupOrderList;

    onEdit() {
      setState(() => isEdit = !isEdit);
    }

    onAdd() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => GroupInfoBottomSheet(),
      );
    }

    onReorder(int oldIndex, int newIndex) async {
      if (oldIndex < newIndex) newIndex -= 1;

      String orderId = groupOrderList.removeAt(oldIndex);
      groupOrderList.insert(newIndex, orderId);

      await userMethod.updateUser(userInfo: userInfo);
    }

    onItem(GroupInfoClass groupInfo) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => GroupInfoBottomSheet(groupInfo: groupInfo),
      );
    }

    return StreamBuilder<Object>(
      stream: groupMethod.stream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CommonNull();

        List<GroupInfoClass> groupInfoList =
            groupMethod.getGroupInfoList(snapshot: snapshot);

        groupInfoList = getGroupInfoOrderList(groupOrderList, groupInfoList);

        onRemove(GroupInfoClass groupInfo) {
          if (groupInfoList.length == 1) {
            showDialog(
              context: context,
              builder: (context) => AlertPopup(
                desc: '최소 1개 이상의 그룹이 존재해야 합니다.',
                buttonText: '확인',
                height: 158,
                onTap: () => navigatorPop(context),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertPopup(
                desc: '삭제 시, 그룹 내 할 일도 모두 삭제됩니다.',
                buttonText: '삭제',
                isCancel: true,
                height: 158,
                onTap: () async {
                  userInfo.groupOrderList.remove(groupInfo.gid);

                  await userMethod.updateUser(userInfo: userInfo);
                  await groupMethod.removeGroup(gid: groupInfo.gid);

                  navigatorPop(context);
                },
              ),
            );
          }
        }

        return CommonBackground(
          child: CommonScaffold(
            appBarInfo: AppBarInfoClass(title: '그룹 관리', actions: [
              GroupEditButton(
                isEdit: isEdit,
                isLight: isLight,
                onEdit: onEdit,
              )
            ]),
            body: Column(
              children: [
                Expanded(
                  child: ReorderableListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: groupInfoList.length,
                    onReorder: onReorder,
                    itemBuilder: (context, index) {
                      return Padding(
                        key: Key(groupInfoList[index].gid),
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: GroupItemButton(
                          groupInfo: groupInfoList[index],
                          isEdit: isEdit,
                          onItem: onItem,
                          onRemove: onRemove,
                        ),
                      );
                    },
                  ),
                ),
                CommonButton(
                  text: '+ 그룹 추가',
                  outerPadding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  textColor: Colors.white,
                  buttonColor: isLight ? textColor : darkContainerColor,
                  isBold: true,
                  verticalPadding: 12.5,
                  borderRadius: 5,
                  onTap: onAdd,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
