import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonCircle.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';

class RecordCalendarStickerItem extends StatelessWidget {
  RecordCalendarStickerItem({super.key, required this.sticker});

  StickerClass sticker;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    bool isMark = sticker.mark != null;
    ColorClass colorInfo = sticker.color;
    Color color = isLight
        ? isMark
            ? colorInfo.s200
            : colorInfo.s50
        : isMark
            ? colorInfo.s300
            : darkButtonColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: CommonCircle(color: color, size: 5),
    );
  }
}
