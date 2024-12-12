import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonImage.dart';
import 'package:todo_tracker_app/common/CommonModalButton.dart';
import 'package:todo_tracker_app/common/CommonModalSheet.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';

class ImageSelectionModalSheet extends StatelessWidget {
  ImageSelectionModalSheet({
    super.key,
    required this.uint8List,
    required this.onSlide,
    required this.onRemove,
  });

  Uint8List uint8List;
  Function() onSlide, onRemove;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonModalSheet(
      title: '사진',
      height: 500,
      child: Column(
        children: [
          CommonImage(
            uint8List: uint8List,
            width: double.infinity,
            height: 300,
            onTap: (_) => onSlide(),
          ),
          CommonSpace(height: 10),
          Row(
            children: [
              CommonModalButton(
                svgName: 'image',
                actionText: '사진 보기',
                isBold: !isLight,
                color: isLight ? textColor : darkTextColor,
                onTap: onSlide,
              ),
              CommonSpace(width: 10),
              CommonModalButton(
                svgName: 'remove',
                isBold: !isLight,
                actionText: '삭제하기',
                color: red.s200,
                onTap: onRemove,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
