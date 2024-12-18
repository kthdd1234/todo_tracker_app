import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonImageButton.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';

class SettingPremium extends StatelessWidget {
  SettingPremium({super.key, required this.text, required this.onTap});

  String text;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    return CommonImageButton(
      path: 'deep-red',
      text: text,
      initFontSize: fontSize - 2,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
      onTap: onTap,
    );
  }
}
