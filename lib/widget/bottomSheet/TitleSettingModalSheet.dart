import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonModalItem.dart';
import 'package:todo_tracker_app/common/CommonModalSheet.dart';
import 'package:todo_tracker_app/common/CommonOutlineInputField.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/list/ColorList.dart';

class TitleSettingModalSheet extends StatefulWidget {
  TitleSettingModalSheet({super.key, required this.userInfo});

  UserInfoClass userInfo;

  @override
  State<TitleSettingModalSheet> createState() => _TitleSettingModalSheetState();
}

class _TitleSettingModalSheetState extends State<TitleSettingModalSheet> {
  String selectedColorName = '남색';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.userInfo.titleInfo.title;
    selectedColorName = widget.userInfo.titleInfo.colorName;

    super.initState();
  }

  onColor(String colorName) {
    setState(() => selectedColorName = colorName);
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    ColorClass color = getColorClass(selectedColorName);
    double bottom = MediaQuery.of(context).viewInsets.bottom;

    onEditingComplete() async {
      TitleInfoClass titleInfo = widget.userInfo.titleInfo;

      titleInfo.title = controller.text;
      titleInfo.colorName = selectedColorName;

      // await userMethod.updateUser(userInfo: widget.userInfo);
      // navigatorPop(context);
    }

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: CommonModalSheet(
        title: '제목 편집',
        height: 205,
        child: CommonContainer(
          innerPadding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              CommonModalItem(
                title: '색상',
                onTap: () {},
                child: ColorList(
                  selectedColorName: selectedColorName,
                  onColor: onColor,
                ),
              ),
              CommonSpace(height: 15),
              CommonOutlineInputField(
                controller: controller,
                hintText: '제목을 입력해주세요',
                selectedColor: isLight ? color.s200 : color.s300,
                onSuffixIcon: onEditingComplete,
                onEditingComplete: onEditingComplete,
                onChanged: (_) => setState(() {}),
              )
            ],
          ),
        ),
      ),
    );
  }
}
