import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';

class CommonImageButton extends StatelessWidget {
  CommonImageButton({
    super.key,
    required this.path,
    required this.text,
    required this.padding,
    required this.onTap,
    this.isBold,
    this.width,
    this.nameArgs,
    this.initFontSize,
  });

  String path, text;
  EdgeInsets padding;
  double? width, initFontSize;
  bool? isBold;
  Map<String, String>? nameArgs;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/$path.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: padding,
        child: CommonText(
          text: text,
          color: Colors.white,
          nameArgs: nameArgs,
          isBold: isBold,
          initFontSize: initFontSize ?? fontSize,
        ),
      ),
    );
  }
}
