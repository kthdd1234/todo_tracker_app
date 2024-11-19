// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';

class MemoField extends StatelessWidget {
  MemoField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.cursorColor,
    this.fontSize,
    this.autofocus,
    this.onEditingComplete,
    this.textInputAction,
    this.hintText,
    this.contentPadding,
    this.textAlign,
  });

  String? hintText;
  double? fontSize;
  bool? autofocus;
  TextEditingController controller;
  TextInputAction? textInputAction;
  EdgeInsets? contentPadding;
  Color? cursorColor;
  TextAlign? textAlign;
  Function(String) onChanged;
  Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return TextFormField(
      controller: controller,
      autofocus: autofocus ?? true,
      maxLines: null,
      minLines: null,
      cursorColor: cursorColor,
      textInputAction: textInputAction ?? TextInputAction.newline,
      textAlign: textAlign ?? TextAlign.left,
      style: TextStyle(
        fontSize: fontSize,
        color: isLight ? Colors.black : darkTextColor,
        fontWeight: isLight ? FontWeight.normal : FontWeight.bold,
      ),
      decoration: InputDecoration(
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        isDense: true,
        border: InputBorder.none,
        hintText: hintText ?? '메모를 입력해주세요 :D'.tr(),
        hintStyle: TextStyle(color: grey.s400),
      ),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
    );
  }
}
