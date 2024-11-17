import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';

class CommonOutlineInputField extends StatelessWidget {
  CommonOutlineInputField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onEditingComplete,
    required this.selectedColor,
    this.autofocus,
    this.outerPadding,
    this.onChanged,
    this.onSuffixIcon,
  });

  String hintText;
  TextEditingController controller;
  bool? autofocus;
  EdgeInsets? outerPadding;
  Color selectedColor;
  Function() onEditingComplete;
  Function(String)? onChanged;
  Function()? onSuffixIcon;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Padding(
      padding: outerPadding ?? const EdgeInsets.all(0.0),
      child: TextFormField(
        style: TextStyle(
          color: isLight ? textColor : darkTextColor,
          fontWeight: isLight ? FontWeight.normal : FontWeight.bold,
        ),
        controller: controller,
        autofocus: autofocus ?? true,
        cursorColor: selectedColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 25),
          hintText: hintText.tr(),
          hintStyle: TextStyle(color: grey.s400),
          filled: true,
          fillColor: isLight ? whiteBgBtnColor : const Color(0xff3D3E4B),
          suffixIcon: GestureDetector(
            onTap: onSuffixIcon,
            child: UnconstrainedBox(
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: controller.text == ''
                      ? isLight
                          ? grey.s300
                          : grey.original
                      : selectedColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.arrow_upward_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
      ),
    );
  }
}
