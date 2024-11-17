import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/enum.dart';

class CommonSegmented extends StatelessWidget {
  CommonSegmented({
    super.key,
    required this.selectedSegment,
    required this.children,
    required this.onSegmentedChanged,
    required this.thumbColor,
    this.padding,
  });

  EdgeInsets? padding;
  SegmentedTypeEnum selectedSegment;
  Map<SegmentedTypeEnum, Widget> children;
  Color thumbColor;
  Function(SegmentedTypeEnum? type) onSegmentedChanged;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return SizedBox(
      width: double.infinity,
      child: CupertinoSlidingSegmentedControl(
        padding: padding ?? const EdgeInsets.all(3),
        backgroundColor: isLight ? Colors.white : darkNotSelectedBgColor,
        thumbColor: isLight ? thumbColor : darkNotSelectedTextColor,
        groupValue: selectedSegment,
        children: children,
        onValueChanged: onSegmentedChanged,
      ),
    );
  }
}
