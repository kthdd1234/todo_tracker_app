import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonInputField.dart';
import 'package:todo_tracker_app/common/CommonModalSheet.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';

class GroupNameBottomSheet extends StatefulWidget {
  GroupNameBottomSheet({
    super.key,
    required this.onCompleted,
    // this.groupInfo,
  });

  // CategoryInfoClass? groupInfo;
  Function(String) onCompleted;

  @override
  State<GroupNameBottomSheet> createState() => _GroupNameBottomSheetState();
}

class _GroupNameBottomSheetState extends State<GroupNameBottomSheet> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // if (widget.groupInfo != null) {
    //   controller.text = widget.groupInfo!.name;
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: CommonModalSheet(
        title: '그룹 추가',
        height: 125,
        child: CommonContainer(
          outerPadding: const EdgeInsets.only(bottom: 5),
          child: CommonInputField(
            controller: controller,
            keyboardType: TextInputType.text,
            cursorColor: isLight ? textColor : Colors.white,
            hintText: '이름을 입력해주세요',
            onCompleted: () => widget.onCompleted(controller.text),
          ),
        ),
      ),
    );
  }
}
