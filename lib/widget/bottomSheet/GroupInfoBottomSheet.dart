import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonColorList.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonModalItem.dart';
import 'package:todo_tracker_app/common/CommonModalSheet.dart';
import 'package:todo_tracker_app/common/CommonOutlineInputField.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/provider/PremiumProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/func.dart';

class GroupInfoBottomSheet extends StatefulWidget {
  GroupInfoBottomSheet({super.key, this.groupInfo});

  GroupInfoClass? groupInfo;

  @override
  State<GroupInfoBottomSheet> createState() => _GroupInfoBottomSheetState();
}

class _GroupInfoBottomSheetState extends State<GroupInfoBottomSheet> {
  String selectedColorName = '남색';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.groupInfo != null) {
      controller.text = widget.groupInfo!.name;
      selectedColorName = widget.groupInfo!.colorName;
    }

    super.initState();
  }

  onColor(String colorName) {
    setState(() => selectedColorName = colorName);
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    bool isPremium = context.watch<PremiumProvider>().isPremium;

    onEditingComplete() async {
      DateTime now = DateTime.now();

      if (widget.groupInfo == null) {
        String newGid = uuid();

        await groupMethod.addGroup(
          gid: newGid,
          groupInfo: GroupInfoClass(
            gid: newGid,
            name: controller.text,
            colorName: selectedColorName,
            createDateTime: now,
            isOpen: true,
            taskInfoList: [],
          ),
        );

        userInfo.groupOrderList.add(newGid);
        await userMethod.updateUser(userInfo: userInfo);
      } else {
        GroupInfoClass groupInfo = widget.groupInfo!;

        groupInfo.name = controller.text;
        groupInfo.colorName = selectedColorName;

        await groupMethod.updateGroup(gid: groupInfo.gid, groupInfo: groupInfo);
      }

      navigatorPop(context);
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: CommonModalSheet(
        title: '그룹 ${widget.groupInfo == null ? '추가' : '수정'}',
        height: 210,
        child: CommonContainer(
          innerPadding: const EdgeInsets.only(
            left: 15,
            top: 0,
            right: 15,
            bottom: 0,
          ),
          child: ListView(
            children: [
              CommonModalItem(
                title: '색상',
                onTap: () {},
                child: CommonColorList(
                  selectedColorName: selectedColorName,
                  onColor: onColor,
                ),
              ),
              CommonSpace(height: 17.5),
              CommonOutlineInputField(
                controller: controller,
                hintText: '제목을 입력해주세요',
                selectedColor: isLight
                    ? getColorClass(selectedColorName).s200
                    : getColorClass(selectedColorName).s300,
                onSuffixIcon: onEditingComplete,
                onEditingComplete: onEditingComplete,
                onChanged: (_) => setState(() {}),
              )
            ],
          ),
        ),
      ),
    );
  }
}
