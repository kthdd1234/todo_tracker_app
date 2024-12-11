import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonBackground.dart';
import 'package:todo_tracker_app/common/CommonButton.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonScaffold.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/provider/ReloadProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';

class FontPage extends StatelessWidget {
  const FontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '글꼴'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [FontPreview(), FontSize(), FontList()],
            ),
          ),
        ),
      ),
    );
  }
}

class FontPreview extends StatelessWidget {
  FontPreview({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> fontPreviewList = [
      "글꼴 미리보기입니다.",
      "가나다라마바사아자차카타파하",
      "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
      "abcdefghijklnmopqrstuvwxyz",
      "いち、に、さん、よん、ご、ろく、なな",
      "0123456789!@#%^&*()",
    ];

    return CommonContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fontPreviewList
            .map((font) => CommonText(text: font, isNotTr: true))
            .toList(),
      ),
    );
  }
}

class FontSize extends StatelessWidget {
  FontSize({super.key});

  @override
  Widget build(BuildContext context) {
    List<double> fontSizeList = [13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0];

    bool isReload = context.watch<ReloadProvider>().isReload;
    bool isLight = context.watch<ThemeProvider>().isLight;
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;

    double fontSize = userInfo.fontSize;

    onChanged(double newValue) async {
      userInfo.fontSize = newValue;

      log('$newValue');

      await userMethod.updateUser(userInfo: userInfo);
      context.read<ReloadProvider>().setReload(!isReload);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(text: '크기'),
          CommonSpace(height: 5),
          Row(
            children: fontSizeList
                .map((size) => Expanded(
                      child: CommonButton(
                        isNotTr: true,
                        outerPadding: EdgeInsets.only(
                          right: fontSize != 20 ? 5 : 0,
                        ),
                        text: '${size.toInt()}',
                        textColor: isLight
                            ? fontSize == size
                                ? Colors.white
                                : Colors.black
                            : fontSize == size
                                ? Colors.black
                                : Colors.white,
                        buttonColor: isLight
                            ? fontSize == size
                                ? textColor
                                : Colors.white
                            : fontSize == size
                                ? Colors.white
                                : darkContainerColor,
                        isBold: false,
                        initFontSize: fontSize.toDouble(),
                        verticalPadding: 10,
                        borderRadius: 5,
                        onTap: () => onChanged(size),
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

class FontList extends StatelessWidget {
  FontList({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    bool isReload = context.watch<ReloadProvider>().isReload;

    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;

    double fontSize = defaultFontSize;
    String fontFamily = userInfo.fontFamily;

    onChanged(String newValue) async {
      userInfo.fontFamily = newValue;
      await userMethod.updateUser(userInfo: userInfo);

      context.read<ReloadProvider>().setReload(!isReload);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(text: '종류'),
          CommonSpace(height: 10),
          Column(
            children: fontFamilyList
                .map(
                  (info) => CommonContainer(
                    onTap: () => onChanged(info['fontFamily']!),
                    innerPadding: const EdgeInsets.only(left: 20, right: 5),
                    outerPadding: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        info['name']!.tr(),
                        style: TextStyle(
                          fontFamily: info['fontFamily'],
                          color: isLight ? Colors.black : Colors.white,
                          fontSize: fontSize,
                        ),
                      ),
                      trailing: Radio<String>(
                        activeColor: isLight ? textColor : Colors.white,
                        value: info['fontFamily']!,
                        groupValue: fontFamily,
                        onChanged: (_) => onChanged(info['fontFamily']!),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
