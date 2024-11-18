import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/func.dart';

speedDialChildButton({
  required bool isLight,
  required String svg,
  required String lable,
  required ColorClass color,
  required Function() onTap,
}) {
  return SpeedDialChild(
    shape: const CircleBorder(),
    child: svgAsset(
      name: svg,
      width: 15,
      color: isLight ? Colors.white : color.s200,
    ),
    backgroundColor: isLight ? color.s200 : darkButtonColor,
    labelWidget: Padding(
      padding: const EdgeInsets.only(right: 10),
      child: CommonText(text: lable, color: Colors.white, isBold: true),
    ),
    onTap: onTap,
  );
}
