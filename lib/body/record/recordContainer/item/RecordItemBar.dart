import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonVerticalBar.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';

class RecordItemBar extends StatelessWidget {
  RecordItemBar({super.key, required this.color});

  ColorClass color;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonVerticalBar(
      width: 3,
      right: 10,
      color: isLight ? color.s200 : color.s300,
    );
  }
}
