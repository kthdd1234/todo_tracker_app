import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';

class SearchInputBar extends StatelessWidget {
  SearchInputBar({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.prefixColor,
    required this.hintText,
    required this.onSuffixIcon,
    required this.onEditingComplete,
  });

  FocusNode focusNode;
  TextEditingController controller;
  Color prefixColor;
  String hintText;
  Function() onSuffixIcon, onEditingComplete;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.read<ThemeProvider>().isLight;
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 40,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          style: TextStyle(
            color: isLight ? textColor : Colors.white,
            fontSize: fontSize - 1,
          ),
          cursorColor: isLight ? textColor : Colors.white,
          cursorHeight: 14,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.only(top: 5),
            hintText: hintText.tr(),
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            filled: true,
            fillColor: isLight ? Colors.white : darkContainerColor,
            prefixIcon: UnconstrainedBox(
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: prefixColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: onSuffixIcon,
              child: Icon(Icons.close_rounded, color: grey.s400),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          onEditingComplete: onEditingComplete,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
      ),
    );
  }
}
