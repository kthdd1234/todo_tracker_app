import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonHorizentalBar.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/widget/memo/MemoBackground.dart';

class MemoContainer extends StatelessWidget {
  MemoContainer({
    super.key,
    required this.onTap,
    required this.child,
    this.height,
  });

  Widget child;
  double? height;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    Color containerColor = isLight ? memoBgColor : darkContainerColor;

    return CommonContainer(
      height: height,
      onTap: onTap,
      radius: 0,
      color: containerColor,
      innerPadding: const EdgeInsets.all(0),
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment:
            height != null ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          CommonHorizentalBar(colorName: '주황색'),
          CustomPaint(
            painter: MemoBackground(isLight: isLight, color: orange.s50),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12.5,
              ),
              child: child,
            ),
          ),
          CommonHorizentalBar(colorName: '주황색'),
        ],
      ),
    );
  }
}
