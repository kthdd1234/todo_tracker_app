import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonBackground.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/func.dart';

class CommonModalSheet extends StatelessWidget {
  CommonModalSheet({
    super.key,
    required this.height,
    required this.child,
    this.title,
    this.initFontSize,
    this.color,
    this.isBack,
    this.isNotTr,
    this.background,
    this.actionButton,
  });

  String? title, background;
  Color? color;
  double height;
  bool? isBack, isNotTr;
  double? initFontSize;
  Widget? actionButton;
  Widget child;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonBackground(
      background: background,
      width: double.infinity,
      height: height,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      isRadius: true,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              title != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        isBack == true
                            ? InkWell(
                                onTap: () => navigatorPop(context),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 15,
                                    right: 15,
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: isLight ? textColor : Colors.white,
                                    size: 16,
                                  ),
                                ),
                              )
                            : const CommonNull(),
                        actionButton != null
                            ? Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.only(
                                  bottom: 10,
                                  left: 23,
                                  right: 5,
                                ),
                              )
                            : CommonNull(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: CommonText(
                              text: title!,
                              initFontSize: initFontSize,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              isBold: !isLight,
                              isNotTr: isNotTr,
                              color: color,
                            ),
                          ),
                        ),
                        actionButton != null
                            ? actionButton!
                            : const CommonNull(),
                        isBack == true
                            ? const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.transparent,
                                  size: 16,
                                ),
                              )
                            : const CommonNull(),
                      ],
                    )
                  : const CommonNull(),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
