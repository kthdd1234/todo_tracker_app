import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonButton.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonImageButton.dart';
import 'package:todo_tracker_app/common/CommonModalSheet.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ReloadProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/button/GroupButton.dart';

class GroupBottomSheet extends StatefulWidget {
  const GroupBottomSheet({super.key});

  @override
  State<GroupBottomSheet> createState() => _GroupBottomSheetState();
}

class _GroupBottomSheetState extends State<GroupBottomSheet> {
  String selectedGroupId = '';

  onSelection() {
    //
  }

  onManege() {
    //
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ReloadProvider>().isReload;

    bool isLight = context.watch<ThemeProvider>().isLight;
    double fontSize = context.watch<FontSizeProvider>().fintSize;
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    return CommonModalSheet(
      title: '그룹을 선택해주세요',
      height: 400,
      isBack: true,
      child: CommonContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                GroupButton(
                  selectedGroupId: selectedGroupId,
                  onSelection: onSelection,
                )
              ],
            ),
            const Spacer(),
            CommonImageButton(
              path: 'deep-blue',
              text: '그룹 관리',
              isBold: true,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12.5),
              onTap: onManege,
            )
            // CommonButton(
            //   text: '그룹 관리',
            //   textColor: Colors.white,
            //   buttonColor: textColor,
            //   verticalPadding: 12.5,
            //   borderRadius: 7,
            //   onTap: onManege,
            // )
          ],
        ),
      ),
    );
  }
}
