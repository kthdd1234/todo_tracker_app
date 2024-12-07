import 'package:flutter/material.dart';
import 'package:todo_tracker_app/util/class.dart';

class MemoInfoListProvider extends ChangeNotifier {
  List<MemoInfoClass> memoInfoList = [];

  void changeMemoInfoList({required List<MemoInfoClass> newMemoInfoList}) {
    memoInfoList = newMemoInfoList;
    notifyListeners();
  }
}
