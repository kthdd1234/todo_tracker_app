import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_tracker_app/util/final.dart';

class CommonInputField extends StatelessWidget {
  CommonInputField({
    super.key,
    required this.controller,
    required this.cursorColor,
    required this.hintText,
    required this.keyboardType,
    required this.onCompleted,
    this.onChanged,
    this.cursorHeight,
    this.textAlign,
    this.prefix,
    this.suffix,
  });

  TextEditingController controller;
  Color cursorColor;
  String hintText;
  TextInputType keyboardType;
  double? cursorHeight;
  TextAlign? textAlign;
  Widget? prefix, suffix;
  Function(String)? onChanged;
  Function() onCompleted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: true,
      keyboardType: keyboardType,
      cursorColor: cursorColor,
      cursorHeight: cursorHeight,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(color: cursorColor),
      decoration: InputDecoration(
        prefix: prefix,
        suffix: suffix,
        hintText: hintText.tr(),
        hintStyle: TextStyle(color: grey.s400),
        contentPadding: const EdgeInsets.all(0),
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
      onChanged: onChanged,
      onEditingComplete: onCompleted,
    );
  }
}
