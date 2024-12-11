import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';

class SettingTitle extends StatelessWidget {
  SettingTitle({super.key, required this.title});

  String title;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.read<ThemeProvider>().isLight;
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    return CommonText(
      text: title,
      initFontSize: fontSize + 1,
      color: isLight ? darkButtonColor : darkTextColor,
    );
  }
}
