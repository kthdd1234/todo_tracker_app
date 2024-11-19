import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonCircle.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';

class CommonColorList extends StatelessWidget {
  CommonColorList({
    super.key,
    required this.selectedColorName,
    required this.onColor,
  });

  String selectedColorName;
  Function(String) onColor;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.7,
      height: 30,
      child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: colorList
              .map(
                (color) => Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: GestureDetector(
                    onTap: () => onColor(color.colorName),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        CommonCircle(
                          color: isLight ? color.s100 : color.s300,
                          size: 30,
                        ),
                        selectedColorName == color.colorName
                            ? svgAsset(
                                name: 'mark-O',
                                width: 16,
                                color: isLight ? color.s300 : color.s50,
                              )
                            : const CommonNull(),
                      ],
                    ),
                  ),
                ),
              )
              .toList()),
    );
  }
}
