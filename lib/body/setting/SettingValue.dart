import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';

class SettingValue extends StatelessWidget {
  SettingValue({super.key, this.text, required this.isVersion});

  String? text;
  bool isVersion;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.read<ThemeProvider>().isLight;

    return text != null
        ? CommonText(
            text: text!,
            color: isLight ? Colors.grey : Colors.white,
            isNotTr: isVersion,
          )
        : const CommonNull();
  }
}
