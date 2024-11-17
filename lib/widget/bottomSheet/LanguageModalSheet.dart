// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonModalButton.dart';
import 'package:todo_tracker_app/common/CommonModalSheet.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/provider/ReloadProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/func.dart';

class LanguageModalSheet extends StatefulWidget {
  const LanguageModalSheet({super.key});

  @override
  State<LanguageModalSheet> createState() => _LanguageModalSheetState();
}

class _LanguageModalSheetState extends State<LanguageModalSheet> {
  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isLight = context.watch<ThemeProvider>().isLight;
    bool isReload = context.watch<ReloadProvider>().isReload;

    onLanguage(String lang) async {
      await context.setLocale(Locale(lang));
      context.read<ReloadProvider>().setReload(!isReload);

      navigatorPop(context);
    }

    btn({required String svgName, required String text, required String lang}) {
      return CommonModalButton(
        bgColor: isLight
            ? locale == lang
                ? textColor
                : Colors.white
            : locale == lang
                ? textColor
                : darkContainerColor,
        svgName: svgName,
        actionText: text,
        color: isLight
            ? locale == lang
                ? Colors.white
                : textColor
            : Colors.white,
        isBold: locale == lang,
        isNotSvgColor: true,
        isNotTr: true,
        onTap: () => onLanguage(lang),
      );
    }

    return CommonModalSheet(
      title: '언어',
      height: 186,
      child: Row(
        children: [
          btn(svgName: 'Usa', text: 'English', lang: 'en'),
          CommonSpace(width: 5),
          btn(svgName: 'Korea', text: '한국어', lang: 'ko'),
          CommonSpace(width: 5),
          btn(svgName: 'Japan', text: '日本語', lang: 'ja'),
        ],
      ),
    );
  }
}
