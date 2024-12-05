import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/func.dart';

class GroupButton extends StatelessWidget {
  GroupButton({
    super.key,
    required this.selectedGroupId,
    required this.groupInfo,
    required this.onSelection,
  });

  String selectedGroupId;
  GroupInfoClass groupInfo;
  Function(GroupInfoClass) onSelection;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    double fontSize = context.watch<FontSizeProvider>().fintSize;
    ColorClass color = getColorClass(groupInfo.colorName);

    return InkWell(
      onTap: () => onSelection(groupInfo),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isLight ? color.s50 : darkBgColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: CommonText(
          text: groupInfo.name,
          color: isLight ? color.original : darkTextColor,
          isNotTr: true,
          initFontSize: fontSize - 1,
        ),
      ),
    );
  }
}

 // bool isSelected = selectedGroupId == '';

    // Color lightBgColor = isSelected ? color.s50 : grey.s100;
    // Color darkBgColor = isSelected ? color.s300 : darkButtonColor;

    // Color lightTextColor = isSelected ? color.original : Colors.grey;
    // Color darkTextColor = isSelected ? Colors.white : grey.s200;