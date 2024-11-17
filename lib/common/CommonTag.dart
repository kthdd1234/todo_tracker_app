import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/util/final.dart';

class CommonTag extends StatelessWidget {
  CommonTag({
    super.key,
    required this.text,
    required this.textColor,
    required this.bgColor,
    required this.onTap,
    this.innerPadding,
    this.isBold,
    this.isImage,
    this.initFontSize,
    this.vertical,
    this.isNotTr,
    this.isOutlined,
  });

  String text;
  Color textColor, bgColor;
  bool? isBold, isNotTr, isImage, isOutlined;
  double? initFontSize, vertical;
  EdgeInsets? innerPadding;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: innerPadding ?? const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: vertical ?? 5, horizontal: 7.5),
          decoration: BoxDecoration(
            image: isImage == true
                ? const DecorationImage(
                    image: AssetImage('assets/image/t-4.png'),
                    fit: BoxFit.cover,
                  )
                : null,
            color: bgColor,
            borderRadius: BorderRadius.circular(5),
            border: isOutlined == true
                ? Border.all(width: 0.5, color: grey.s300)
                : null,
          ),
          child: CommonText(
            text: text,
            color: textColor,
            isBold: isBold,
            initFontSize: initFontSize,
            isNotTr: isNotTr,
          ),
        ),
      ),
    );
  }
}
