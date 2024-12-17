import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/body/record/recordContainer/item/RecordItemLength.dart';
import 'package:todo_tracker_app/common/CommonDivider.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonTag.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/bottomSheet/TitleSettingModalSheet.dart';

class RecordContainerTitle extends StatefulWidget {
  const RecordContainerTitle({super.key});

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
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    bool isLight = context.watch<ThemeProvider>().isLight;
    String title = userInfo.titleInfo.title;
    ColorClass color = getColorClass(userInfo.titleInfo.colorName);

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
            const ReocrdItemLength()
          ],
        ),
        CommonSpace(height: 10),
        CommonDivider(),
      ],
    );
  }
}
