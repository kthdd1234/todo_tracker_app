import 'package:flutter/material.dart';
import 'package:todo_tracker_app/common/CommonSvgButton.dart';
import 'package:todo_tracker_app/util/class.dart';

class RecordItemMaker extends StatelessWidget {
  RecordItemMaker({
    super.key,
    required this.color,
    required this.onTap,
    this.mark,
  });

  String? mark;
  ColorClass color;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 15,
            right: 3,
          ),
          child: CommonSvgButton(
            width: 20,
            name: 'mark-${mark ?? 'E'}',
            color: color.s200,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
