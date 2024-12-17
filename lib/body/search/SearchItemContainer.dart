import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/body/search/searchItem/SearchItemMemo.dart';
import 'package:todo_tracker_app/body/search/searchItem/SearchItemTodo.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/GroupInfoListProvider.dart';
import 'package:todo_tracker_app/provider/MemoInfoListProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/enum.dart';
import 'package:todo_tracker_app/util/func.dart';

class SearchItemContainer extends StatelessWidget {
  SearchItemContainer({
    super.key,
    required this.keyword,
    required this.selectedSegment,
    required this.titleDateTime,
  });

  String keyword;
  SegmentedTypeEnum selectedSegment;
  DateTime titleDateTime;

  @override
  Widget build(BuildContext context) {
    bool isTodo = selectedSegment == SegmentedTypeEnum.todo;
    String locale = context.locale.toString();

    int year = titleDateTime.year;
    int month = titleDateTime.month;

    int startDay = DateTime(year, month, 1).day;
    int endDay = DateTime(year, month + 1, 0).day;

    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    List<GroupInfoClass> groupInfoList =
        context.watch<GroupInfoListProvider>().groupInfoList;
    List<MemoInfoClass> memoInfoList =
        context.watch<MemoInfoListProvider>().memoInfoList;

    List<SearchItemTodoClass> searchItemTodoList = [];
    List<SearchItemMemoClass> searchItemMemoList = [];

    // todo
    for (var i = startDay; i <= endDay; i++) {
      DateTime targetDateTime = DateTime(year, month, i);
      List<RecordItemClass> recordItemList = getRecordItemList(
        locale: locale,
        targetDateTime: targetDateTime,
        groupInfoList: groupInfoList,
        taskOrderList: userInfo.taskOrderList,
      );

      if (recordItemList.isNotEmpty) {
        SearchItemTodoClass searchItemTodo = SearchItemTodoClass(
          dateTime: targetDateTime,
          recordItemList: recordItemList,
        );

        if (keyword == '') {
          searchItemTodoList.add(searchItemTodo);
        } else {
          for (final recordItem in recordItemList) {
            String name = recordItem.taskInfo.name;
            bool isContain = name.contains(keyword);

            if (isContain) searchItemTodoList.add(searchItemTodo);
          }
        }
      }
    }

    // memo
    for (var i = startDay; i <= endDay; i++) {
      DateTime targetDateTime = DateTime(year, month, i);
      int targetKey = dateTimeKey(targetDateTime);

      for (var memoInfo in memoInfoList) {
        if (memoInfo.dateTimeKey == targetKey) {
          SearchItemMemoClass searchItemMemo = SearchItemMemoClass(
            dateTime: targetDateTime,
            memoInfo: memoInfo,
          );

          if (keyword != '') {
            String? memo = memoInfo.text;

            if (memo != null) {
              bool isContain = memo.contains(keyword);

              if (isContain) searchItemMemoList.add(searchItemMemo);
            }
          } else {
            searchItemMemoList.add(searchItemMemo);
          }
        }
      }
    }

    List<SearchItemTodo> todoList = searchItemTodoList.reversed
        .map(
          (searchItemTodo) => SearchItemTodo(searchItemTodo: searchItemTodo),
        )
        .toList();
    List<SearchItemMemo> memoList = searchItemMemoList.reversed
        .map((searchItemMemo) => SearchItemMemo(searchItemMemo: searchItemMemo))
        .toList();

    Widget emptyText =
        Center(child: CommonText(text: '검색 결과가 없어요.', color: Colors.grey));

    Widget searchTodo = Expanded(
      child: todoList.isNotEmpty
          ? SingleChildScrollView(child: Column(children: todoList))
          : emptyText,
    );
    Widget searchMemo = Expanded(
      child: memoList.isNotEmpty
          ? SingleChildScrollView(child: Column(children: memoList))
          : emptyText,
    );

    return isTodo ? searchTodo : searchMemo;
  }
}
