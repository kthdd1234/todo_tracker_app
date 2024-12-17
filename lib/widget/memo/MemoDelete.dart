import 'package:flutter/material.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';

class MemoDelete extends StatelessWidget {
  MemoDelete({super.key, required this.memoInfo});

  MemoInfoClass? memoInfo;

  @override
  Widget build(BuildContext context) {
    String? path = memoInfo?.path;
    String? imgUrl = memoInfo?.imgUrl;
    String? memo = memoInfo?.text;

    onDeleted() async {
      if (imgUrl != null && path != null) {
        await removeImage(imgUrl: imgUrl, path: path);
      }

      await memoMethod.removeMemo(mid: memoInfo!.dateTimeKey.toString());
      navigatorPop(context);
    }

    return imgUrl != null || memo != null
        ? InkWell(
            onTap: onDeleted,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: svgAsset(name: 'trash', width: 20, color: red.original),
            ),
          )
        : const CommonNull();
  }
}
