import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_tracker_app/body/search/SearchAppBar.dart';
import 'package:todo_tracker_app/body/search/SearchInputBar.dart';
import 'package:todo_tracker_app/body/search/SearchItemContainer.dart';
import 'package:todo_tracker_app/util/enum.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/popup/CalendarPopup.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  DateTime titleDateTime = DateTime.now();
  SegmentedTypeEnum selectedSegment = SegmentedTypeEnum.todo;
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();

  onSegmentedChanged(type) {
    setState(() => selectedSegment = type);
  }

  onTitleDateTime() {
    showDialog(
      context: context,
      builder: (context) => CalendarPopup(
        view: DateRangePickerView.year,
        initialdDateTime: titleDateTime,
        onSelectionChanged: (args) async {
          setState(() => titleDateTime = args.value);
          navigatorPop(context);
        },
      ),
    );
  }

  onClear() {
    setState(() => controller.text = '');
    FocusScope.of(context).unfocus();
  }

  onEditingComplete() {
    setState(() {});
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    bool isTodo = selectedSegment == SegmentedTypeEnum.todo;

    return Column(
      children: [
        SearchAppBar(
          titleDateTime: titleDateTime,
          selectedSegment: selectedSegment,
          onSegmentedChanged: onSegmentedChanged,
          onTitleDateTime: onTitleDateTime,
        ),
        SearchInputBar(
          focusNode: focusNode,
          controller: controller,
          hintText: '${isTodo ? '할 일' : '메모'} 검색',
          prefixColor: isTodo ? indigo.s200 : orange.s200,
          onSuffixIcon: onClear,
          onEditingComplete: onEditingComplete,
        ),
        SearchItemContainer(
          keyword: controller.text,
          selectedSegment: selectedSegment,
          titleDateTime: titleDateTime,
        )
      ],
    );
  }
}