import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ReloadProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';

class BackgroundButton extends StatelessWidget {
  BackgroundButton({
    super.key,
    required this.path,
    required this.name,
  });

  String path, name;

  @override
  Widget build(BuildContext context) {
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    bool isReload = context.watch<ReloadProvider>().isReload;
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    onBackground(String background) async {
      log(background);
      userInfo.background = background;

      await userMethod.updateUser(userInfo: userInfo);
      context.read<ReloadProvider>().setReload(!isReload);
    }

    return Expanded(
      child: InkWell(
        onTap: () => onBackground(path),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/images/$path.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                ),
                path == userInfo.background
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Mask(height: 200, opacity: 0.2),
                          Center(
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                  size: 30,
                                  weight: 1,
                                ),
                                CommonSpace(height: 5),
                                CommonText(
                                  text: '적용 중',
                                  color: Colors.white,
                                  isBold: true,
                                  initFontSize: fontSize - 1,
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    : const CommonNull()
              ],
            ),
            CommonSpace(height: 5),
            CommonText(text: name, initFontSize: fontSize - 2, isNotTr: true)
          ],
        ),
      ),
    );
  }
}

class Mask extends StatelessWidget {
  Mask({super.key, this.height, this.opacity});

  double? height, opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(opacity ?? 0.5),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
