import 'package:flutter/cupertino.dart';
import 'package:todo_tracker_app/body/record/recordCalendar/RecordCalendarStickerItem.dart';
import 'package:todo_tracker_app/util/class.dart';

class RecordCalendarStickerList extends StatelessWidget {
  RecordCalendarStickerList({
    super.key,
    required this.start,
    required this.end,
    required this.stickerList,
  });

  int start, end;
  List<StickerClass> stickerList;

  @override
  Widget build(BuildContext context) {
    List<StickerClass> lineList = [];

    for (var i = start; i <= end; i++) {
      if (stickerList.asMap().containsKey(i)) {
        lineList.add(stickerList[i]);
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: lineList
          .map((sticker) => RecordCalendarStickerItem(sticker: sticker))
          .toList(),
    );
  }
}
