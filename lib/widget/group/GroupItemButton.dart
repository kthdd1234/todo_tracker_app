import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonCircle.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonSvgText.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/enum.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/group/GroupOrderButton.dart';
import 'package:todo_tracker_app/widget/group/GroupRemoveButton.dart';

class GroupItemButton extends StatelessWidget {
  GroupItemButton({
    super.key,
    required this.groupInfo,
    required this.isEdit,
    required this.onItem,
    required this.onRemove,
  });

  GroupInfoClass groupInfo;
  bool isEdit;
  Function(GroupInfoClass) onItem, onRemove;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    String colorName = groupInfo.colorName;
    ColorClass color = getColorClass(colorName);
    int count = groupInfo.taskInfoList.length;
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    return Row(
      children: [
        GroupRemoveButton(isEdit: isEdit, onRemove: () => onRemove(groupInfo)),
        Expanded(
          child: InkWell(
            onTap: () => onItem(groupInfo),
            child: CommonContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonCircle(color: color.s200, size: 10),
                  CommonSpace(width: 10),
                  Expanded(
                    child: CommonText(
                      text: groupInfo.name,
                      isNotTr: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  CommonSpace(width: 30),
                  CommonSvgText(
                    text: '$count',
                    initFontSize: fontSize - 1, // 14
                    textColor: isLight ? grey.original : Colors.white,
                    svgColor: isLight ? grey.original : Colors.white,
                    svgWidth: 6,
                    svgLeft: 6,
                    isNotTr: true,
                    svgDirection: SvgDirectionEnum.right,
                  )
                ],
              ),
            ),
          ),
        ),
        GroupOrderButton(isEdit: isEdit)
      ],
    );
  }
}
