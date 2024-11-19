import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_tracker_app/common/CommonSvgButton.dart';

class RecordMarkButton extends StatelessWidget {
  RecordMarkButton({
    super.key,
    required this.svgName,
    required this.color,
    required this.width,
    required this.onTap,
  });

  String svgName;
  Color color;
  double width;
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
            width: width,
            name: svgName,
            color: color,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
