import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/body/record/widget/RecordMarkButton.dart';
import 'package:todo_tracker_app/common/CommonDivider.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/common/CommonVerticalBar.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/final.dart';

class RecordContainerItem extends StatelessWidget {
  const RecordContainerItem({super.key});

  onMark() {}

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    double fontSize = context.watch<FontSizeProvider>().fintSize;
    ColorClass color = indigo;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 0,
                  child: CommonVerticalBar(
                    width: 3,
                    right: 10,
                    color: isLight ? color.s200 : color.s300,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: '책 읽기',
                        overflow: TextOverflow.clip,
                        isBold: !isLight,
                        initFontSize: fontSize,
                        softWrap: false,
                        textAlign: TextAlign.start,
                        isNotTr: true,
                      ),
                      '' != null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: CommonText(
                                text: '딱 30분만 읽음',
                                color: isLight ? grey.original : grey.s400,
                                initFontSize: fontSize - 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                isBold: !isLight,
                                isNotTr: true,
                              ),
                            )
                          : const CommonNull()
                    ],
                  ),
                ),
                const Spacer(),
                CommonSpace(width: 15),
                RecordMarkButton(
                  svgName: 'mark-${'E'}',
                  width: 20,
                  color: color.s200,
                  onTap: onMark,
                ),
              ],
            ),
          ),
        ),
        CommonDivider()
      ],
    );
  }
}
