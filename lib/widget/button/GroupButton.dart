import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';

class GroupButton extends StatelessWidget {
  GroupButton({
    super.key,
    required this.selectedGroupId,
    required this.onSelection,
  });

  String selectedGroupId;
  Function() onSelection;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    bool isSelected = selectedGroupId == '';
    ColorClass color = indigo;

    Color lightBgColor = isSelected ? color.s50 : grey.s100;
    Color darkBgColor = isSelected ? color.s300 : darkButtonColor;

    Color lightTextColor = isSelected ? color.original : Colors.grey;
    Color darkTextColor = isSelected ? Colors.white : grey.s200;

    return InkWell(
      onTap: onSelection,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isLight ? lightBgColor : darkBgColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: CommonText(
          text: '할 일',
          color: isLight ? lightTextColor : darkTextColor,
          isNotTr: true,
        ),
      ),
    );
  }
}
