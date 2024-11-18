import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonDivider.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/final.dart';

class CommonModalItem extends StatelessWidget {
  CommonModalItem({
    super.key,
    required this.title,
    required this.child,
    this.vertical,
    required this.onTap,
  });

  String title;
  Widget child;
  double? vertical;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: vertical ?? 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(text: title, isBold: !isLight),
                CommonSpace(width: 50),
                child
              ],
            ),
          ),
          CommonDivider(color: isLight ? grey.s200 : Colors.white12),
        ],
      ),
    );
  }
}
